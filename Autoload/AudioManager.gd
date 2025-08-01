extends Node

@onready var attack_sound = $Attack
@onready var flip_sound = $Flip
var is_muted = false

func play_attack():
	attack_sound.play()

func play_flip():
	flip_sound.play()

func toggle_mute(toggled: bool):
	is_muted = true
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled)
