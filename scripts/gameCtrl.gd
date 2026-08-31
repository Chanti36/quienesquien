extends Node

var i_dia  := 1
var i_time := 1
var i_tutorialCount := 0
var b_onMenu := true


@onready var saveData:   Node    = $SaveData
@onready var transition: Control = $Transition

@onready var _button_nueva_partida:	Button = $MainMenu/MarginButtons/VBoxContainer/Button_NuevaPartida
@onready var _button_continuar: 	Button = $MainMenu/MarginButtons/VBoxContainer/Button_Continuar
@onready var _button_ajustes: 		Button = $MainMenu/MarginButtons/VBoxContainer/Button_Ajustes
@onready var _button_salir: 		Button = $MainMenu/MarginButtons/VBoxContainer/Button_Salir


func _ready() -> void:
	pass
	TriggerMenuButtons(true)
	#
	$DialogueCtrl.visible = false
	$Mapa.visible         = false
	$Juguete.visible      = false
	$MainMenu.visible     = true
	$Transition.visible   = true


#SIGNAL TRIGGERED WHEN A DIALOGUE ENDS
func _on_dialogue_end() -> void:
	#esto va a haber que gestionarlo mejor
	i_time += 1
	if i_time > 6: i_time = 0; i_dia += 1
	if i_dia == 1 && i_time == 5:
		transition.DoTransition("tabla")
	print("DEBUG __> to map in day ", i_dia, ", time ", i_time)
	transition.DoTransition("map", i_dia, i_time)


#region BOTONES MENU
#NUEVA PARTIDA

func _on_nueva_partida_button_up() -> void:
	TriggerMenuButtons(false)
	transition.DoTransition("dialogue", i_dia, i_time, "intro")

#CONTINUAR
func _on_continuar_button_up() -> void:
	TriggerMenuButtons(false)
	transition.DoTransition("map")

#SALIR
func _on_salir_button_up() -> void:
	TriggerMenuButtons(false)
	get_tree().quit()

#True / False to Enable /Disable menu buttons
func TriggerMenuButtons(state : bool) -> void:
	_button_nueva_partida.disabled = !state
	_button_ajustes.disabled = !state
	_button_salir.disabled = !state
	
	#TODO: LOAD DIA CARGADO PARA CHECKEAR CONTINUAR
	
	if state && i_dia != 1: _button_continuar.disabled = false
	else: _button_continuar.disabled = true

#endregion


#TODO
# DIALOGUE DRAWER ZONA CLICKS
# TRANSICION SI VAS MUY RÁPIDO
#
#
#dia1 noche lorelien  [!!!!!!!!!!!!!!!!!!!!!YA SE QUE ESTÁS LEYENDO ESTO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Los personajes pasan al palacio]
# X2  al de arriba
#
#
#
#
#
#
