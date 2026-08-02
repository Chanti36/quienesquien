extends Control

@onready var _dialogueDrawer: MarginContainer = $DialogueDrawer

var b_overSafeArea := false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_accept"):
		if b_overSafeArea:
			return
		#_dialogueDrawer.Next()


func _mouse_over_dialogue_box() -> void:
	b_overSafeArea = true

func _mouse_exit_dialogue_box() -> void:
	b_overSafeArea = false
