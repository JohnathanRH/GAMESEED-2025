extends Node

# For easy access.

var card_anim_speed := 1.0

signal cardAnimSpeedSet

func setCardAnimSpeed(newSpeed : float):
	card_anim_speed = newSpeed
	cardAnimSpeedSet.emit()
	
