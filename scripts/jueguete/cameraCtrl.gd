extends Node2D

@onready var cam: Camera3D = $"../Camera3D"

var b_leftClick  := false
var b_rightClick := false
var b_shaking    := false

var f_spd := 16.0
var f_ref := 16.0
var f_lookspd := 2.0

var i_shakeLv := 1

var v2_mousePos := Vector2(0,0)

var v3_currAngle := Vector3(-45, 0, 0)

func _ready() -> void:
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(delta: float) -> void:
	v2_mousePos = get_global_mouse_position()
	global_position = lerp(global_position, v2_mousePos, f_spd * delta)
	
	LookAround(delta)
	Shake()

func LookAround(delta: float)->void:
	
	if v2_mousePos.y > 615:
		cam.rotation_degrees.x =\
		 lerp(cam.rotation_degrees.x, v3_currAngle.x, f_lookspd * delta)
	elif v2_mousePos.y < 153:
		cam.rotation_degrees.x =\
		lerp(cam.rotation_degrees.x, v3_currAngle.x, f_lookspd * delta)
	else:
		cam.rotation_degrees.x =\
		 lerp(cam.rotation_degrees.x, v3_currAngle.x, f_lookspd * delta)
	
	if v2_mousePos.x > 820:
		cam.rotation_degrees.y =\
	lerp(cam.rotation_degrees.y, v3_currAngle.y, f_lookspd * delta)
	elif v2_mousePos.x < 204:
		cam.rotation_degrees.y =\
	lerp(cam.rotation_degrees.y, v3_currAngle.y, f_lookspd * delta)
	else:
		cam.rotation_degrees.y =\
	lerp(cam.rotation_degrees.y, v3_currAngle.y, f_lookspd * delta)
	



func Shake() -> void:
	
	if !b_shaking:
		return
