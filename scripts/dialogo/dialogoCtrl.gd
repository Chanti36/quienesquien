extends Control

@onready var _dialogueDrawer: MarginContainer = $DialogueDrawer


const INTRO1   = preload("uid://dgph3v7ymsh8")
const BG_PLAZA = preload("uid://cfr62qfbhhd02")

const ALONSO          = preload("uid://c7tfua0ildk74")
const CATALINA        = preload("uid://bg4uouogdg5u1")
const CECILIA         = preload("uid://bq427vmurng6d")
const DACIANO         = preload("uid://caw0byqcwj3xc")
const ELENA           = preload("uid://brdp8pgtgrxm1")
const ENEMESIO        = preload("uid://dq882hxgsbqr2")
const FERNAN          = preload("uid://b403mdh0a6fj0")
const IRIS            = preload("uid://cvk4p8hnju0n8")
const IÑIGO           = preload("uid://cudi8dsxscxb3")
const MARGARITA       = preload("uid://cpfvfx07fw4jk")
const MIGUEL          = preload("uid://bd3dp42f7hjo6")
const NIÑO_ENCONTRADO = preload("uid://cuhgw2cufyi5v")
const PEPA            = preload("uid://c4tf4uppuc7ej")


@onready var _bg: TextureRect = $Parallax/ParallaxBackground/ParallaxLayer/Control/Background
@onready var _pj: Control =$Parallax/ParallaxChar/ParallaxLayer/PJChar/Char

var b_overSafeArea := false

var i_phraseIndex := 0
var i_day := 0
var i_time := 0


func SetUp(location : String, dia : int, tiempo : int) -> void:
	$Parallax/ParallaxBackground.visible = true
	$Parallax/ParallaxChar.visible       = true
	
	i_day = dia
	i_time = tiempo
	
	if   location == "plaza":  _bg.texture = BG_PLAZA
	elif location == "intro":  _bg.texture = INTRO1
	elif location == "intro2": _bg.texture = BG_PLAZA
	else: _bg.texture = null;  push_error("DEBUG -> NO BG TEXTURE IMPLEMENTED")
	
	_pj.texture = null
	
	if i_day == 1:
		if   i_time == 1: _dialogueDrawer.Start("test/intro")
		elif i_time == 2: _dialogueDrawer.Start("test/dia1")
		elif i_time == 3: _dialogueDrawer.Start("test/dia1tarde")
		elif i_time == 4: _dialogueDrawer.Start("test/dia1noche")


	#if   pj == "alonso":         _pj.texture = ALONSO
	#elif pj == "catalina":       _pj.texture = CATALINA
	#elif pj == "cecilia":        _pj.texture = CECILIA
	#elif pj == "daciano":        _pj.texture = DACIANO
	#elif pj == "elena":          _pj.texture = ELENA
	#elif pj == "enemesio":       _pj.texture = ENEMESIO
	#elif pj == "fernan":         _pj.texture = FERNAN
	#elif pj == "iris":           _pj.texture = IRIS
	#elif pj == "inigo":          _pj.texture = IÑIGO
	#elif pj == "margarita":      _pj.texture = MARGARITA
	#elif pj == "miguel":         _pj.texture = MIGUEL
	#elif pj == "ninoEncontrado": _pj.texture = NIÑO_ENCONTRADO
	#elif pj == "pepa":           _pj.texture = PEPA



func _on_dialogue_drawer_END() -> void:
	i_phraseIndex = 0
	DIALOGUEEND.emit()

signal DIALOGUEEND

#HARDCODEAR EVENTOS EN LAS CONVERSACIONES
func _on_dialogueDrawer_nextphrase() -> void:
	i_phraseIndex += 1
	
	
	if i_day == 1: 
		if i_time == 1: pass
		elif i_time == 2: pass
	
