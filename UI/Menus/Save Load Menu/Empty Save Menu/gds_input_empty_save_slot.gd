extends PanelContainer

@onready var save = PlayerVariables.save_file as PlayerSaveFile

func _on_button_pressed() -> void:
	var name = $VBoxContainer/TextEdit.text
	
	save.setName(name)
	save.setLevel(1)
	PlayerVariables.save_data()
	get_tree().change_scene_to_file(save.stage)
