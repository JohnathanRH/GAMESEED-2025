extends Node

@onready var attack_sound = $Attack
@onready var flip_sound = $Flip

func play_attack():
	attack_sound.play()

func play_flip():
	flip_sound.play()
