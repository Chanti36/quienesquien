extends Node

const SAVEDATADIR = "res://misc/savedata/"

var ContentToSave: Dictionary = {
	"Day" = 0
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
