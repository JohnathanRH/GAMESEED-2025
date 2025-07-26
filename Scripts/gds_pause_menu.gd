extends CanvasLayer

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
