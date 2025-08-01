extends Node2D

# No use for this at the moment
# Safe to delete
func _ready() -> void:
	$Panel/ScnPauseMenu.option_pressed.connect(on_option_button_pressed)
	
func on_option_button_pressed():
	$OptionMenu.visible = true
	pass
