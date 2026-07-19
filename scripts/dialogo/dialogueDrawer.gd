extends MarginContainer


var _engine: PatterEngine
var _flow: PatterFlow


const SPEAKERFOLDER: String = "res://personajes/"
const DIALOGUEFOLDER: String = "res://dialogos/"

const _dialogueEntry = preload("uid://rfhdnnqfwv1m")
@onready var _dialogueEntriesContaier: Control =$PanelContainer/ScrollContainer/DialogueEntries
@onready var _scrollContainer: ScrollContainer = $PanelContainer/ScrollContainer
@onready var _scrollBar : ScrollBar = _scrollContainer.get_v_scroll_bar()


func _ready() -> void:
	#SCROLLBAR
	_scrollBar.changed.connect(_onScrollBarChanged)
	Start("tour")


func Start(dialogueName : String) -> void:
	var dialoguePath = "%s%s.patterc" % [DIALOGUEFOLDER, dialogueName]
	if !ResourceLoader.exists(dialogueName):
		_append("ERROR: no dialogue found")
	#PATTER
	var json := FileAccess.get_file_as_string(dialoguePath)
	if json == "":
		_append("ERROR: missing text")
		return
	var bundle = PatterBundle.load_from_string(json)
	if bundle == null:
		_append("ERROR: failed to parse")
		return
	_engine = PatterEngine.new(bundle)


func Next() -> void:
	var entry = _dialogueEntry.instantiate()
	_dialogueEntriesContaier.add_child(entry)
	entry.SetContent(
		GetSpeakerResource("speakerTest"), 
		"Like a fly to the ointment, your conscience sticks to it. The limbed and headed machine of pain and undignified suffering is firing up again. It wants to walk the desert. Hurting. Longing. Dancing to disco music.",
	 	"[success]")

func GetSpeakerResource(speakerName : String) -> Speaker:
	var speakerPath = "%s%s.tres" % [SPEAKERFOLDER, speakerName]
	if ResourceLoader.exists(speakerPath):
		return load(speakerPath)
	return Speaker.new()

func _onScrollBarChanged() -> void:
	var scrollValue = _scrollBar.max_value
	if scrollValue != _scrollContainer.scroll_vertical:
		_scrollContainer.scroll_vertical = scrollValue

#region PATTER

func _append(bbcode: String) -> void:
	var label := RichTextLabel.new()
	label.bbcode_enabled = true
	label.fit_content = true
	label.text = bbcode
	_transcript.add_child(label)
	await get_tree().process_frame  # let the label size before jumping to the end
	_scroll.scroll_vertical = int(_scroll.get_v_scroll_bar().max_value)




#endregion
