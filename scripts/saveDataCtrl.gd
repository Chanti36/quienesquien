extends Node

const SAVEDATADIR = "res://misc/saves/savegame.save"

var ContentToSave: Dictionary = {
	"Day" = 0, # 0 1 2 3 4
	"TextSize" = 1, # 1 - 3
	"WindowType" = 0 # 0 = Windowed, 1 = Fullscreen
}

func Save():
	var file = FileAccess.open(SAVEDATADIR, FileAccess.WRITE)
	file.store_var(ContentToSave.duplicate())
	file.close()


func Load():
	if FileAccess.file_exists(SAVEDATADIR):
		var file = FileAccess.open(SAVEDATADIR, FileAccess.READ)
		var data = file.get_var()
		file.close()

func CheckLoad() -> bool:
	if FileAccess.file_exists(SAVEDATADIR):
		return true
	return false
