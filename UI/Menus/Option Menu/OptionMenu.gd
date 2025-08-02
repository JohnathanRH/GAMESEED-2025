extends CanvasLayer

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioManager.toggle_mute(!toggled_on)


func _on_button_pressed() -> void:
	self.visible = false


func _on_h_slider_value_changed(value: float) -> void:
	GlobalVariables.emit_signal("check_time_changed", value)
