extends Control

const SPEAKERFOLDER: String = "res://personajes/"
const DIALOGUEFOLDER: String = "res://dialogos/"

const _dialogueEntry = preload("uid://rfhdnnqfwv1m")
const _dialogueOption = preload("uid://d2iqnyr5luebc")

@onready var _dialogueEntriesContaier: Control = $PanelContainer/ScrollContainer/DialogueEntries
@onready var _scrollContainer: ScrollContainer = $PanelContainer/ScrollContainer
@onready var _scrollBar : ScrollBar = _scrollContainer.get_v_scroll_bar()


var loreline: Loreline = Loreline.shared()

var b_dialogueShown := false

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
	Start("test/prueba")


func Start(dialogueName : String) -> void:
	var dialoguePath = "%s%s.lor" % [DIALOGUEFOLDER, dialogueName]
	var script = await loreline.parse(dialoguePath)
	if script == null:
		push_error("Failed to parse " + dialoguePath)
		return
		
	loreline.play(script, _on_dialogue, _on_choice, _on_finished)
	print("--START ", dialogueName)



#region LORELINE

func _on_dialogue(interp: LorelineInterpreter, character: String, text: String, tags: Array, advance: Callable) -> void:
	if !b_dialogueShown:
		if character != "":
			var display_name: String = interp.get_character_field(character, "name")
			if display_name != "":
				character = display_name
			else:
				push_error("no display name for character: " + character)
			Next(character + ": " + text)
		else:
			push_error("no character name on: " + text)
			Next(text)
		b_dialogueShown = true
	
	while not Input.is_action_just_pressed("ui_accept"):
		await get_tree().process_frame
		
	advance.call()
	b_dialogueShown = false


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
	
	# In a real project, wait for player input here.
	# For this example, automatically select the first enabled choice:
	#select.call(enabled_indices[0])


func _on_finished(_interp: LorelineInterpreter) -> void:
	print("--- The End ---")
	DIALOGUEENDED.emit()

signal DIALOGUEENDED

#endregion

func Next(text : String) -> void:
	var entry = _dialogueEntry.instantiate()
	_dialogueEntriesContaier.add_child(entry)
	_fade_in(entry)
	entry.SetContent(GetSpeakerResource(text.substr(0, text.find(":"))),
					 text.right(text.length()- text.find(":")))


func GetSpeakerResource(speakerName : String) -> Speaker:
	var speakerPath = "%s%s.tres" % [SPEAKERFOLDER, speakerName]
	if ResourceLoader.exists(speakerPath):
		return load(speakerPath)
	var newSpeaker = Speaker.new()
	newSpeaker.name = speakerName
	return newSpeaker

#region FUNCTIONALITY

func _onScrollBarChanged() -> void:
	var scrollValue = _scrollBar.max_value
	if scrollValue != _scrollContainer.scroll_vertical:
		_scrollContainer.scroll_vertical = scrollValue

func _fade_in(node: Control) -> void:
	node.modulate.a = 0
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(node, "modulate:a", 1.0, 0.5)

#
#endregion
