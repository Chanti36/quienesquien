extends Node3D

var b_canInteract := false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_ficha_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		print("clicked")
