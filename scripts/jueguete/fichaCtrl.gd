extends MeshInstance3D

@onready var animationPlayer: AnimationPlayer = $"../AnimationPlayer"

var b_active := true
var b_canInteract := false
var b_looking := false
#como se mueve el area en el trigger puede quedarse en bucle si pones el raton en la zona que deja de estar dentro cuando se mueve

func _on_area_3d_mouse_entered() -> void:
	mouseInput(1)
	#print(position)
func _on_area_3d_mouse_exited() -> void:
	mouseInput(0)

func mouseInput(action : int) -> void:
	#ENTER / EXIT
	if action == 1: material_overlay.set_shader_parameter("size", 1.05)
	else: 			material_overlay.set_shader_parameter("size", 1.00)
	
	if b_active:
		if action == 1: #ENTER
			animationPlayer.play("active_mouse_entered")
			b_canInteract = true
		else: #EXIT
			animationPlayer.play("active_mouse_exited")
			b_canInteract = false
	else:
		if action == 1: #ENTER
			animationPlayer.play("disabled_hover")
			b_canInteract = true
		else:
			b_canInteract = false

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		if b_canInteract:
			if b_active:
				$"../../..".FichaClick(-1) 
				animationPlayer.play("to_disabled")
				b_active = false
			else:
				$"../../..".FichaClick(1) 
				animationPlayer.play("to_active")
				b_active = true
