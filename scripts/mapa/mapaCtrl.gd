extends Control

var b_enMapa := false

var i_day := 0
var i_time := 0

@onready var _transition: Control = $"../Transition"

@onready var btn_bosque:  TextureButton = $Bosque
@onready var btn_cruce:   TextureButton = $"Cruce de caminos"
@onready var btn_iglesia: TextureButton = $Iglesia
@onready var btn_palacio: TextureButton = $Palacio
@onready var btn_plaza:   TextureButton = $Plaza
@onready var btn_sima:    TextureButton = $Sima
@onready var btn_venta:   TextureButton = $Venta

func SetUp(dia : int, tiempo : int) -> void:
	i_day = dia
	i_time = tiempo
	b_enMapa = true
	$Paralax/ParallaxBackground.visible = true
	
	#diable & visibility, hardcodear para cada tiempo en cada dia
	btn_bosque.disabled  = true
	btn_bosque.visible   = false
	btn_venta.disabled   = true
	btn_venta.visible    = false
	btn_cruce.disabled   = true
	btn_cruce.visible    = false
	btn_sima.disabled    = true
	btn_sima.visible     = false
	btn_iglesia.disabled = true
	btn_iglesia.visible  = false
	btn_plaza.disabled   = true
	btn_plaza.visible    = false
	btn_palacio.disabled = true
	btn_palacio.visible  = false
	
	if i_day == 1:
		if   i_time == 2: EnableButton("🏠")
		elif i_time == 3: EnableButton("🏠")
		elif i_time == 4: EnableButton("🏠")
	elif i_day == 2:
		if   i_time == 1: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 2: EnableButton("⛪"); EnableButton("⛲")
		elif i_time == 3: EnableButton("⛪"); EnableButton("🌳")
		elif i_time == 4: EnableButton("⛲"); EnableButton("⛪")
		elif i_time == 5: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 6: EnableButton("⛲"); EnableButton("🏠")
	elif i_day == 3:
		if   i_time == 1: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 2: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 3: EnableButton("🌳"); EnableButton("⛪")
		elif i_time == 4: EnableButton("⛪"); EnableButton("⛲")
		elif i_time == 5: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 6: EnableButton("⛲"); EnableButton("🏰")
	elif i_day == 4:
		if   i_time == 1: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 2: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 3: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 4: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 5: EnableButton("⛲"); EnableButton("🏠")
		elif i_time == 6: EnableButton("⛲"); EnableButton("🏠")

func EnableButton(placeName : String) -> void:
	if placeName == "🌳":#bosque
		btn_bosque.disabled  = false
		btn_bosque.visible   = true
	elif placeName == "🛣️":#cruce
		btn_cruce.disabled   = false
		btn_cruce.visible    = true
	elif placeName == "⛪":#iglesia
		btn_iglesia.disabled = false
		btn_iglesia.visible  = true
	elif placeName == "🏰":#palacio
		btn_palacio.disabled = false
		btn_palacio.visible  = true
	elif placeName == "⛲":#plaza
		btn_plaza.disabled   = false
		btn_plaza.visible    = true
	elif placeName == "⛰️":#sima
		btn_sima.disabled    = false
		btn_sima.visible     = true
	elif placeName == "🏠":#venta
		btn_venta.disabled   = false
		btn_venta.visible    = true
	else: 	push_error("MAPACTRL WRONG BUTTON NAME SET ->  " + placeName)


func Click(placeName : String) -> void:
	print("CLOCKED!!!!!!!!")
	if !b_enMapa:
		return
	
	print("CLOCKED!!!!!!!!")
	
	if i_day == 1:
		if   i_time == 2: _transition.DoTransition("dialogue", i_day, i_time)
		elif i_time == 3: _transition.DoTransition("dialogue", i_day, i_time)
		elif i_time == 4: _transition.DoTransition("dialogue", i_day, i_time)
	elif i_day == 2:
		if   i_time == 1: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 2: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 3: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 4: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 5: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 6: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
	elif i_day == 3:
		if   i_time == 1: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 2: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 3: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 4: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 5: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 6: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
	elif i_day == 4:
		if   i_time == 1: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 2: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 3: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 4: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 5: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)
		elif i_time == 6: 
			if placeName == "":  pass
			elif placeName =="": pass
			else:                push_error("MAPACTRL WRONG BUTTON NAME  PRESSED ??????? ->  " + placeName)

	
	b_enMapa = false


func _on_Bosque() -> void:
	Click("🌳")

func _on_Venta() -> void:
	Click("🏠")

func _on_Cruce_de_caminos() -> void:
	Click("🛣️")

func _on_Sima() -> void:
	Click("⛰️")

func _on_Iglesia() -> void:
	Click("⛪")

func _on_Plaza() -> void:
	Click("⛲")

func _on_Palacio() -> void:
	Click("🏰")


func _on_bosque_mouse_entered() -> void:
	print("pass # Replace with function body.")
