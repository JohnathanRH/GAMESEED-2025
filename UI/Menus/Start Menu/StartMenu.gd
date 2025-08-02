extends Node2D

func _on_btn_start_pressed() -> void:
	SceneManager.load_scene("saveload")

func _on_btn_quit_pressed() -> void:
	get_tree().quit(0)


func _on_btn_options_pressed() -> void:
	$OptionMenu.visible = true
