extends Button

var is_empty = true
var save_path = ""

func setup(savedata: PlayerSaveFile, new_save_path: String):
	text = savedata.name
	save_path = new_save_path
	is_empty = false
	pass

func empty_setup(new_save_path: String):
	text = "Empty Slot"
	save_path = new_save_path
	pass
