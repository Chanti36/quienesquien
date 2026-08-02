extends MarginContainer

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
##
## Avanza automático o con click
##		Si es con clicks dentro o fuera de la caja de texto por coherencia pero barra de scroll
##
##


func _ready() -> void:
	#SCROLLBAR
	_scrollBar.changed.connect(_onScrollBarChanged)
	Start("CoffeeShop")


func Start(dialogueName : String) -> void:
	var dialoguePath = "%s%s.lor" % [DIALOGUEFOLDER, dialogueName]
	var script = await loreline.parse(dialoguePath)
	if script == null:
		push_error("Failed to parse CoffeeShop.lor")
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
			Next("------- " + character + ": " + text)
		else:
			Next(text)
		b_dialogueShown = true
	
	
	#await get_tree().create_timer(0.6).timeout
	
	while not Input.is_action_just_pressed("ui_accept"):
		await get_tree().process_frame
	advance.call()
	b_dialogueShown = false


func _on_choice(_interp: LorelineInterpreter, options: Array, select: Callable) -> void:
	var entry = _dialogueEntry.instantiate()
	_dialogueEntriesContaier.add_child(entry)
	
	var enabled_indices: Array[int] = []
	for i in range(options.size()):
		if options[i]["enabled"]:
			enabled_indices.append(i)
			#print("  [" + str(enabled_indices.size()) + "] " + options[i]["text"])
			var option = _dialogueOption.instantiate()
			entry.get_child(0).get_child(1).add_child(option)
			option.get_child(0).get_child(0).text = str(enabled_indices.size())
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
	
	entry.SetContent( GetSpeakerResource("speakerTest"), text)


func GetSpeakerResource(speakerName : String) -> Speaker:
	var speakerPath = "%s%s.tres" % [SPEAKERFOLDER, speakerName]
	if ResourceLoader.exists(speakerPath):
		return load(speakerPath)
	return Speaker.new()

func _onScrollBarChanged() -> void:
	var scrollValue = _scrollBar.max_value
	if scrollValue != _scrollContainer.scroll_vertical:
		_scrollContainer.scroll_vertical = scrollValue
