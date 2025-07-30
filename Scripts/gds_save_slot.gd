extends Button

var is_empty = true
var save_path = ""

func setup(savedata: PlayerSaveFile, new_save_path: String):
	text = savedata.name
	save_path = new_save_path
	is_empty = false

func empty_setup(new_save_path: String):
	text = "Empty Slot"
	save_path = new_save_path

func _on_pressed() -> void:
	
	PlayerVariables.set_save_path(save_path)
	
	var playerVar = PlayerVariables.save_file
	
	if is_empty:
		get_tree().change_scene_to_file("res://Scenes/UI/scn_input_empty_save_slot.tscn")
		
	else:
		get_tree().change_scene_to_file(playerVar.stage)
