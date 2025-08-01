extends CanvasLayer

var start_menu = "res://UI/Menus/Start Menu/scn_start_menu.tscn"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("btn_pause"):
		visible = !visible;
		get_tree().paused = !get_tree().paused
	pass

func _ready() -> void:
	visible = false;
	pass

func _on_btn_resume_pressed() -> void:
	visible = false
	get_tree().paused = false
	

func _on_btn_quit_pressed() -> void:
	get_tree().quit()


func _on_btn_quit_2_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(start_menu)
