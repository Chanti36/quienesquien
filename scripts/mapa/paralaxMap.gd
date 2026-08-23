extends Control

@onready var parallaxLayer: ParallaxLayer = $"ParallaxBackground/ParallaxLayer"
@onready var parallaxLayer2: ParallaxLayer = $"ParallaxBackground/ParallaxLayer2"
@onready var parallaxLayer3: ParallaxLayer = $"ParallaxBackground/ParallaxLayer3"
@onready var parallaxLayer4: ParallaxLayer = $"ParallaxBackground/ParallaxLayer4"

var v2_mousePos := Vector2(0, 0)
var v2_viewportSize : Vector2
var v2_relativePos := Vector2(0, 0)

var multiplier1 := 2.5
var multiplier2 := 2.0
var multiplier3 := 1.5
var multiplier4 := 1.0

func _ready() -> void:
	v2_viewportSize = get_viewport_rect().size

func _input(event):
	if event is InputEventMouseMotion:
		v2_mousePos.x = event.position.x
		v2_mousePos.y = event.position.y
		
	v2_relativePos.x = (v2_mousePos.x - (v2_viewportSize.x/2)) / (v2_viewportSize.x/2)
	v2_relativePos.y = (v2_mousePos.y - (v2_viewportSize.y/2)) / (v2_viewportSize.y/2)

	parallaxLayer.motion_offset.x = multiplier1 * v2_relativePos.x
	parallaxLayer.motion_offset.y = multiplier1 * v2_relativePos.y * 0.5
	
	parallaxLayer2.motion_offset.x = multiplier2 * v2_relativePos.x
	parallaxLayer2.motion_offset.y = multiplier2 * v2_relativePos.y * 0.5
	
	parallaxLayer3.motion_offset.x = multiplier3 * v2_relativePos.x
	parallaxLayer3.motion_offset.y = multiplier3 * v2_relativePos.y * 0.5
	
	parallaxLayer4.motion_offset.x = multiplier4 * v2_relativePos.x
	parallaxLayer4.motion_offset.y = multiplier4 * v2_relativePos.y * 0.5
	
