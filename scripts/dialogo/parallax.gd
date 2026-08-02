extends Control

@onready var _bg: ParallaxLayer = $ParallaxBackground/ParallaxLayer
@onready var _char: ParallaxLayer = $ParallaxChar/ParallaxLayer

var v2_mousePos := Vector2(0, 0)
var v2_viewportSize : Vector2
var v2_relativePos := Vector2(0, 0)

var multiplier := 5.0
var multiplier2 := 3.0

func _ready() -> void:
	v2_viewportSize = get_viewport_rect().size

func _input(event):
	if event is InputEventMouseMotion:
		v2_mousePos.x = event.position.x
		v2_mousePos.y = event.position.y
		
	v2_relativePos.x = (v2_mousePos.x - (v2_viewportSize.x/2)) / (v2_viewportSize.x/2)
	v2_relativePos.y = (v2_mousePos.y - (v2_viewportSize.y/2)) / (v2_viewportSize.y/2)

	_bg.motion_offset.x = multiplier * v2_relativePos.x
	_bg.motion_offset.y = multiplier * v2_relativePos.y * 0.5
	
	_char.motion_offset.x = multiplier2 * v2_relativePos.x
	_char.motion_offset.y = multiplier2 * v2_relativePos.y * 0.5
