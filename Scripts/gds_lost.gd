extends Node2D

func _on_btn_quit_pressed() -> void:
	get_tree().quit(0)


func _on_btn_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/scn_placeholder_stage.tscn")
