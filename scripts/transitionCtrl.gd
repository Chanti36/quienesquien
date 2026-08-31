extends Control

var b_ontransition := false
var b_event := false

var f_timer := 0.0

var str_goto :=""

var i_day := 1
var i_time := 1
var str_place := ""

@onready var scn_dialogue: Control = $"../DialogueCtrl"
@onready var scn_juguete: Node3D = $"../Juguete"
@onready var scn_mapa: Control = $"../Mapa"
@onready var scn_main_menu: Control = $"../MainMenu"


#func _ready() -> void:
	##DoTransition()
	#pass


func DoTransition(gotoScene : String, dia : int = 0, hora : int = 0, place = "") -> void:
	if b_ontransition:
		print("DEBUG-> ALREADY ON TRANSITION")
		return
	f_timer = 0.0
	b_ontransition = true
	str_goto  = gotoScene
	i_day     = dia
	i_time    = hora
	str_place = place
	$Fade/AnimationPlayer.play("TransitionFade")



func _process(delta: float) -> void:
	if !b_ontransition:
		return
	
	f_timer += delta
	
	if f_timer <= 2.0:
		$Black.material.set("shader_parameter/progress", f_timer*.5)
	if f_timer >=0.3 && f_timer <= 2.3:
		$Color.material.set("shader_parameter/progress", (f_timer*.5) - 0.1)
	
	if f_timer > 1 && !b_event:
		b_event = true
		
		scn_dialogue.visible  = false
		$"../DialogueCtrl/Parallax/ParallaxBackground".visible = false
		$"../DialogueCtrl/Parallax/ParallaxChar".visible       = false
		scn_juguete.visible   = false
		scn_mapa.visible      = false
		$"../Mapa/Paralax/ParallaxBackground".visible = false
		scn_main_menu.visible = false
		
		#if str_goto == "intro"   :
			#print("DEBUG -> TransitioN to: intro") 
			#scn_dialogue.visible = true
			#scn_dialogue.SetUp("intro")
		#if str_goto == "intro2"  :
			#print("DEBUG -> TransitioN to: intro 2") 
			#scn_dialogue.visible = true
			#scn_dialogue.SetUp("intro2")
			
		if str_goto == "map"     :
			#hardcodeado feillo el tutorial pero funciona
			if i_day == 1 && i_time == 2:
				print("DEBUG -> TransitioN to: dialogue") 
				scn_dialogue.visible = true
				scn_dialogue.SetUp("plaza", 1, 2)
				return
			
			print("DEBUG -> TransitioN to: map") 
			scn_mapa.visible = true
			scn_mapa.SetUp(i_day, i_time)

		if str_goto == "dialogue":
			print("DEBUG -> TransitioN to: dialogue") 
			scn_dialogue.visible = true
			scn_dialogue.SetUp(str_place, i_day, i_time)

		if str_goto == "tabla"   :
			print("DEBUG -> TransitioN to: tabla")
			scn_juguete.visible = true
			#TODO: SETUP TABLA
	
	
	if f_timer >= 2.3:
		f_timer = 2.3
		b_ontransition = false
		b_event = false
