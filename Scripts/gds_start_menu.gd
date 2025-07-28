extends Node2D

var start_path = "res://Scenes/UI/scn_save_load_menu.tscn"

func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file(start_path)

func _on_btn_quit_pressed() -> void:
	get_tree().quit(0)
