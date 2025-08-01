extends CanvasLayer

@onready var player = PlayerVariables.save_file as PlayerSaveFile
var start_menu = "res://UI/Menus/Start Menu/scn_start_menu.tscn"

signal option_pressed

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
	SceneManager.load_scene("start")


func _on_btn_options_pressed() -> void:
	emit_signal("option_pressed")
