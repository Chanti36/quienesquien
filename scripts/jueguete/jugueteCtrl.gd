extends Node3D

@onready var _tabla: MeshInstance3D = $Tabla
var _vignetteMaterial : Material
var v3_tablaPos := Vector3(0,0,0)

var b_canEnd := false

var arr_fichas = []
var i_fichasCount := 0


var f_shakeTimer := 0.0
var f_shakeValue := 2.5

var f_vignetteValue := 0.0


func _ready() -> void:
	for i in $Tabla.get_children():
		arr_fichas.append(i)
		i_fichasCount +=1
	
	v3_tablaPos = _tabla.position
	_vignetteMaterial = $Control/ColorRect.material


func _process(_delta : float) -> void:
	
	var val = lerpf(0.5, 2.5, (float(i_fichasCount) / 12))
	f_vignetteValue = lerpf(f_vignetteValue, val, 0.1)
	_vignetteMaterial.set_shader_parameter("outerRadius", f_vignetteValue)
	
	
	if f_shakeTimer < 0:
		return
	_tabla.position = v3_tablaPos + Vector3(randf_range(-f_shakeValue, f_shakeValue),randf_range(-f_shakeValue, f_shakeValue),randf_range(-f_shakeValue, f_shakeValue))
	f_shakeTimer -=_delta
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


func _on_acusar() -> void:
	if i_fichasCount == 1:
		print("ACUSAR")
	else:
		print("pass")
