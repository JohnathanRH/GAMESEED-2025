extends Node2D

@onready var player = PlayerVariables.save_file as PlayerSaveFile

func _on_btn_quit_pressed() -> void:
	get_tree().quit(0)

func _on_btn_restart_pressed() -> void:
	PlayerVariables.reset_data()
	get_tree().change_scene_to_file(player.stage)


func _on_btn_quit_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/scn_start_menu.tscn")
