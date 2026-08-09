extends Control

var b_ontransition := false
var f_timer := 0.0

func _ready() -> void:
	#DoTransition()
	pass

func _process(delta: float) -> void:
	if !b_ontransition:
		return
	f_timer +=delta
	
	
	if f_timer <= 2.0:
		$Black.material.set("shader_parameter/progress", f_timer*.5)
	if f_timer >=0.3 && f_timer <= 2.3:
		$Color.material.set("shader_parameter/progress", (f_timer*.5) - 0.1)
	
	
	if f_timer >= 2.3:
		f_timer = 2.3
		b_ontransition = false

func DoTransition()->void:
	if b_ontransition:
		return
	f_timer = 0.0
	b_ontransition = true
	
