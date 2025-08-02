extends Node2D

@onready var player = PlayerVariables.save_file as PlayerSaveFile
@onready var enemy = get_node_or_null("../Container/enemy")


func _ready() -> void:
	if player.stage == "5":
		$CanvasLayer/BtnContainer/BtnNext.text = "Restart"

func _on_btn_next_pressed() -> void:
	if(player.stage == "5"):
		player.setStage("1")
		PlayerVariables.save_data()
		print(player.stage)
	PlayerVariables.reset_data()

	SceneManager.load_scene(player.stage)

func _on_btn_quit_pressed() -> void:
	get_tree().quit(0)

func _on_btn_main_menu_pressed() -> void:
	SceneManager.load_scene("start")
