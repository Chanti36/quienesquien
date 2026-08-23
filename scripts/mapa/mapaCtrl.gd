extends Control

var b_enMapa := false

var i_day := 0
var i_time := 0

@onready var btn_bosque: TextureButton = $Bosque
@onready var btn_venta: TextureButton = $Venta
@onready var btn_cruce: TextureButton = $"Cruce de caminos"
@onready var btn_sima: TextureButton = $Sima
@onready var btn_iglesia: TextureButton = $Iglesia
@onready var btn_plaza: TextureButton = $Plaza
@onready var btn_palacio: TextureButton = $Palacio

func SetUp(dia : int, tiempo : int) -> void:
	i_day = dia
	i_time = tiempo
	b_enMapa = true
	$Paralax/ParallaxBackground.visible = true
	
	#diable & visibility, hardcodear para cada tiempo en cada dia
	btn_bosque.disabled  = true
	btn_venta.disabled   = true
	btn_cruce.disabled   = true
	btn_sima.disabled    = true
	btn_iglesia.disabled = true
	btn_plaza.disabled   = true
	btn_palacio.disabled = true
	btn_bosque.visible  = false
	btn_venta.visible   = false
	btn_cruce.visible   = false
	btn_sima.visible    = false
	btn_iglesia.visible = false
	btn_plaza.visible   = false
	btn_palacio.visible = false
	
	if i_day == 0:pass
	elif i_day == 1:
		if   i_time == 1:pass
		elif i_time == 2:pass
		elif i_time == 3:pass
	elif i_day == 2:
		if   i_time == 1:pass
		elif i_time == 2:pass
		elif i_time == 3:pass
	elif i_day == 3:
		if   i_time == 1:pass
		elif i_time == 2:pass
		elif i_time == 3:pass
	elif i_day == 4:
		if   i_time == 1:pass
		elif i_time == 2:pass
		elif i_time == 3:pass
	

func Click():
	if !b_enMapa:
		return
	
	b_enMapa = false


func _on_Bosque() -> void:
	Click()

func _on_Venta() -> void:
	Click()

func _on_Cruce_de_caminos() -> void:
	Click()

func _on_Sima() -> void:
	Click()

func _on_Iglesia() -> void:
	Click()

func _on_Plaza() -> void:
	Click()

func _on_Palacio() -> void:
	Click()
