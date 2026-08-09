extends Node


var i_dia := 0

var b_onMenu := true

@onready var _button_nueva_partida:	Button = $MainMenu/MarginButtons/VBoxContainer/Button_NuevaPartida
@onready var _button_continuar: 	Button = $MainMenu/MarginButtons/VBoxContainer/Button_Continuar
@onready var _button_ajustes: 		Button = $MainMenu/MarginButtons/VBoxContainer/Button_Ajustes
@onready var _button_salir: 		Button = $MainMenu/MarginButtons/VBoxContainer/Button_Salir


func _ready() -> void:
	TriggerMenuButtons(true)



#SIGNAL TRIGGERED WHEN A DIALOGUE ENDS
func _on_dialogue_end() -> void:
	#DO TRANSITION TO MAP SETTING IT UP ON THE CORRECT DAYTIME
	pass # Replace with function body.




#region BOTONES MENU
#NUEVA PARTIDA

func _on_nueva_partida_button_up() -> void:
	TriggerMenuButtons(false)

#CONTINUAR
func _on_continuar_button_up() -> void:
	TriggerMenuButtons(false)

#SALIR
func _on_salir_button_up() -> void:
	TriggerMenuButtons(false)
	get_tree().quit()

#True / False to Enable /Disable menu buttons
func TriggerMenuButtons(state : bool) -> void:
	_button_nueva_partida.disabled = !state
	if state && $SaveData.CheckLoad(): _button_continuar.disabled = false
	else: _button_continuar.disabled = true
	_button_ajustes.disabled = !state
	_button_salir.disabled = !state

#endregion



# SETTEAR EL DIALOGUE DRAWER PARA LA INTRO
# DE LA INTRO TE LLEVA A LA PLAZA
#
#
#
#
