extends Sprite2D

# still empty, all stats and changes towards them are managed in the PlayerSaveFile resource

func _input(event: InputEvent) -> void:
	# Save, for debugging only
	if(event.is_action_pressed("save")):
		PlayerVariables.save_data()
