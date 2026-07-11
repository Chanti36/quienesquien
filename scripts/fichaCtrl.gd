extends MeshInstance3D


func _on_mouse_entered() -> void:
	material_overlay.set_shader_parameter("thickness", 3)
	print("lol")

func _on_mouse_exited() -> void:
	material_overlay.set_shader_parameter("thickness", 0)
	print("e")

#cambia el shader a uno con opacidad o qe se pueda desactivar
