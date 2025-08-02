extends PanelContainer

@onready var save = PlayerVariables.save_file as PlayerSaveFile

func _on_button_pressed() -> void:
	var name = $VBoxContainer/LineEdit.text
	
	save.setName(name)
	save.setLevel(1)
	PlayerVariables.save_data()
	SceneManager.load_scene(save.stage)
