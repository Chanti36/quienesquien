extends Node3D

@onready var _tabla: MeshInstance3D = $Tabla
@onready var _cam: Camera3D = $Camera3D

var b_playing := false

var b_onFocus := false
var b_canEnd := false

var _vignetteMaterial : Material
var v3_tablaPos := Vector3(0, 0, 0)

var arr_fichas = []
var i_fichasCount := 0

var f_shakeTimer := 0.0
var f_shakeValue := 2.5

var f_vignetteValue := 0.0

var v3_defPos := Vector3(0, 0.2, 0.75)
var v3_objPos := Vector3(0, 0, 0)

var f_lerpFocus := 2.0

func _ready() -> void:
	b_playing = false
	for i in $Tabla.get_children():
		arr_fichas.append(i)
		i_fichasCount +=1
	
	v3_tablaPos = _tabla.position
	_vignetteMaterial = $Control/ColorRect.material

func SetUp():
	b_playing = true

func _process(delta : float) -> void:
	
	#VIGNETTE
	var val = lerpf(0.5, 2.5, (float(i_fichasCount-1) / 11.0))
	f_vignetteValue = lerpf(f_vignetteValue, val, 0.1)
	_vignetteMaterial.set_shader_parameter("outerRadius", f_vignetteValue)
	
	#FOV
	if !b_onFocus:
		var lerpval = lerpf(50.0, 75.0, (float(i_fichasCount) / 11))
		_cam.fov = lerpf(_cam.fov, lerpval, 0.1)
	else:
		_cam.fov = lerpf(_cam.fov, 75.0, 0.1)
	
	#FOCUS POSITION
	if f_lerpFocus < 2.0:
		f_lerpFocus += delta
		if b_onFocus:
			_cam.position = Vector3(lerpf(_cam.position.x, v3_objPos.x, 0.05),\
									lerpf(_cam.position.y, v3_objPos.y, 0.05),\
									lerpf(_cam.position.z, v3_objPos.z, 0.05))
		else:
			_cam.position = Vector3(lerpf(_cam.position.x, v3_defPos.x, 0.05),\
									lerpf(_cam.position.y, v3_defPos.y, 0.05),\
									lerpf(_cam.position.z, v3_defPos.z, 0.05))
	
	#SHAKE
	if f_shakeTimer < 0:
		return
	_tabla.position = v3_tablaPos + Vector3(randf_range(-f_shakeValue, f_shakeValue),randf_range(-f_shakeValue, f_shakeValue),randf_range(-f_shakeValue, f_shakeValue))
	f_shakeTimer -= delta
	if f_shakeTimer < 0:
		_tabla.position = v3_tablaPos


func FichaClick(change : int) -> void:
	i_fichasCount += change
	#12 - 1
	
	if i_fichasCount == 1:  b_canEnd = true
	else: 					b_canEnd = false
	
	if   i_fichasCount > 8: ShakeTabla(0)
	elif i_fichasCount > 4: ShakeTabla(1)
	elif i_fichasCount > 2: ShakeTabla(2)
	else				  : ShakeTabla(3)


func FichaFocus(pivot : Node3D)->void:
	if !b_onFocus:
		v3_objPos = pivot.global_position
	f_lerpFocus = 0.0
	b_onFocus = !b_onFocus


func ShakeTabla(intensity : int) -> void:
	if intensity == 0:
		f_shakeTimer = 0.02
		f_shakeValue = .01
		return
	if intensity == 1:
		f_shakeTimer = 0.05
		f_shakeValue = .01
	if intensity == 2:
		f_shakeTimer = 0.1
		f_shakeValue = .015
	if intensity == 3:
		f_shakeTimer = 0.1
		f_shakeValue = .03
		$Control/BotonAcusar.visible = true
	else:
		$Control/BotonAcusar.visible = false




func _on_acusar() -> void:
	if i_fichasCount == 1:
		print("ACUSAR")
	else:
		print("pass")
