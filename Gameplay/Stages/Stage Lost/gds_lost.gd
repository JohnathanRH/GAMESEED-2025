extends Node2D

@onready var player = PlayerVariables.save_file as PlayerSaveFile

func _on_btn_quit_pressed() -> void:
	get_tree().quit(0)


func _on_btn_restart_pressed() -> void:
	PlayerVariables.reset_data()
	SceneManager.load_scene(player.stage)


func _on_btn_quit_2_pressed() -> void:
	SceneManager.load_scene("start")
