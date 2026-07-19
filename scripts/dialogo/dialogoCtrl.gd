extends Control
@onready var _dialogueDrawer: MarginContainer = $DialogueDrawer


func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_accept"):
		_dialogueDrawer.Next()
