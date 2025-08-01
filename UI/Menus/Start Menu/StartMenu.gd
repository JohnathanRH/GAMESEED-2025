extends Node2D

var save_load_menu = "res://UI/Menus/Save Load Menu/scn_save_load_menu.tscn"

func _on_btn_start_pressed() -> void:
	SceneManager.load_scene("saveload")

func _on_btn_quit_pressed() -> void:
	get_tree().quit(0)
