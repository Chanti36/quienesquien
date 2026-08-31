extends MarginContainer

const SPEAKERFOLDER: String = "res://personajes/"
const DIALOGUEFOLDER: String = "res://dialogos/"

const _dialogueEntry = preload("uid://rfhdnnqfwv1m")
const _dialogueOption = preload("uid://d2iqnyr5luebc")

@onready var _dialogueEntriesContaier: Control = $PanelContainer/ScrollContainer/DialogueEntries
@onready var _scrollContainer: ScrollContainer = $PanelContainer/ScrollContainer
@onready var _scrollBar : ScrollBar = _scrollContainer.get_v_scroll_bar()

@onready var _charSprite: TextureRect = $"../Parallax/ParallaxChar/ParallaxLayer/PJChar/Char"
@onready var _charAnim: AnimationPlayer = $"../Parallax/ParallaxChar/ParallaxLayer/PJChar/AnimationPlayer"

var t2d_charSprite : Texture2D
var str_lastCharName := ""


var loreline: Loreline = Loreline.shared()
var b_dialogueShown := false
var b_overSafeArea  := false

var b_dialogueZone  := false
var b_entiesZone    := false



## CUESTIONES
#
## Avanza automático o con click
##		Si es con clicks dentro o fuera de la caja de texto por coherencia pero barra de scroll
##
##


func _ready() -> void:
	#SCROLLBAR
	_scrollBar.changed.connect(_onScrollBarChanged)
	
	await get_tree().create_timer(1.0).timeout
	#Start("test/prueba")


func Start(dialogueName : String) -> void:
	var dialoguePath = "%s%s.lor" % [DIALOGUEFOLDER, dialogueName]
	var script = await loreline.parse(dialoguePath)
	if script == null:
		push_error("Failed to parse " + dialoguePath)
		return
		
	loreline.play(script, _on_dialogue, _on_choice, _on_finished)
	print("DEBUG -> START ", dialogueName)

signal INPUT
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("dialogic_default_action"):
		if !b_overSafeArea:
			INPUT.emit()


	#print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA-> enter")
	#b_overSafeArea = true
	#print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB-> enter")
	#b_overSafeArea = false
#TODO ARREGLAER
func _on_scroll_container_mouse_entered() -> void:
	b_dialogueZone  = true
	#print("!!!!!!!!!!!!!!!!!!!!!!!!!! DEAD ZONE")


func _on_scroll_container_mouse_exited() -> void:
	b_dialogueZone  = false
	#print("?????????????????????????? DEAD ZONE")


func _on_dialogue_entries_mouse_entered() -> void:
	b_entiesZone    = true
	#print("?????????????????????????? DEAD ZONE")


func _on_dialogue_entries_mouse_exited() -> void:
	b_entiesZone    = false
	#print("?????????????????????????? DEAD ZONE")



#region LORELINE
func _on_dialogue(interp: LorelineInterpreter, character: String, text: String, _tags: Array, advance: Callable) -> void:
	if !b_dialogueShown:
		if character != "":
			var display_name: String = interp.get_character_field(character, "name")
			if display_name != "":
				character = display_name
			else:
				push_error("no display name for character: " + character)
			Next(character + ": " + text, true)
		else:
			#push_warning("no character name on: " + text)
			Next(text, false)
		b_dialogueShown = true
	
	#if not Input.is_action_just_pressed("ui_accept"):
		#await  get_tree().process_frame
	await INPUT
	b_dialogueShown = false
	advance.call()
	NEXTPHRASE.emit()

signal NEXTPHRASE

func _on_choice(_interp: LorelineInterpreter, options: Array, select: Callable) -> void:
	var entry = _dialogueEntry.instantiate()
	_dialogueEntriesContaier.add_child(entry)
	
	for i in range(options.size()):
		if options[i]["enabled"]:
			var option = _dialogueOption.instantiate()
			_fade_in(option)
			entry.get_child(0).get_child(1).add_child(option)
			option.get_child(0).get_child(0).text = str(i+1)
			option.get_child(0).get_child(1).text = options[i]["text"]
			option.get_child(0).get_child(1).button_up.connect(SelectChoice.bind(i, entry, select))


func _on_finished(_interp: LorelineInterpreter)->float:
	print("--- The End ---")
	DIALOGUEENDED.emit()
	for i in _dialogueEntriesContaier.get_children():
		_dialogueEntriesContaier.remove_child(i)
	str_lastCharName = ""
	return .1
signal DIALOGUEENDED

#endregion


func SelectChoice(index: int, entry: MarginContainer, select: Callable) -> void:
	for i in entry.get_child(0).get_child(1).get_child_count():
		if index != i:
			#entry.get_child(0).get_child(1).get_child(i).disabled = true
			entry.get_child(0).get_child(1).get_child(i).queue_free()
		else:
			entry.get_child(0).get_child(1).get_child(i).get_child(0).get_child(1).disabled = true
	select.call(index)


func Next(text : String, charName : bool) -> void:
	var entry = _dialogueEntry.instantiate()
	_dialogueEntriesContaier.add_child(entry)
	_fade_in(entry)
	if charName:
		entry.SetContent(text.right(text.length()- text.find(":")), GetSpeakerResource(text.substr(0, text.find(":"))))
	else:
		entry.SetContent(text)


func GetSpeakerResource(speakerName : String) -> Speaker:
	var speakerPath = "%s%s.tres" % [SPEAKERFOLDER, speakerName]
	if ResourceLoader.exists(speakerPath):
		var speaker = load(speakerPath)
		#SET NAME AND PLAY ANIMATION
		if speaker.name != str_lastCharName && speaker.sprite != null && speaker.sprite != _charSprite.texture:
			t2d_charSprite = speaker.sprite
			_charAnim.play("changeSprite")
			str_lastCharName = speaker.name
		return speaker
	push_error("GetSpeakerResource NO RESOURCE ->  " + speakerName)
	var newSpeaker = Speaker.new()
	newSpeaker.name = speakerName
	return newSpeaker


#CALLED FROM ANIMATION
func ChangeCharSprite()-> void:
	if t2d_charSprite:
		_charSprite.texture = t2d_charSprite


#region FUNCTIONALITY

func _onScrollBarChanged() -> void:
	var scrollValue = _scrollBar.max_value
	if scrollValue != _scrollContainer.scroll_vertical:
		_scrollContainer.scroll_vertical = int(scrollValue)

func _fade_in(node: Control) -> void:
	node.modulate.a = 0
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(node, "modulate:a", 1.0, 0.5)

#
#endregion
