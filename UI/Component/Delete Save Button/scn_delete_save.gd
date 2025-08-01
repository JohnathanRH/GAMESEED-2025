extends Button

var delete_path = ""

func setup(save_path : String):
	delete_path = save_path

func empty_setup():
	disabled = true
	modulate = Color.TRANSPARENT


func _on_pressed() -> void:
	DirAccess.remove_absolute(delete_path)
	get_tree().change_scene_to_file("res://UI/Menus/Save Load Menu/scn_save_load_menu.tscn")
