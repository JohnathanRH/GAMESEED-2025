extends Node

@onready var attack_sound = $Attack
@onready var flip1_sound = $Flip1
@onready var heal_sound = $Heal
@onready var flip2_sound = $Flip2
@onready var flip3_sound = $Flip3
@onready var ignite_sound = $Ignite
@onready var shield_break_sound = $ShieldBreak
@onready var shield_equip_sound = $ShieldEquip

var is_muted = false

func play_attack():
	attack_sound.play()

func play_flip():
	randomize()
	var flip = randi_range(0, 3)
	match flip:
		0:
			flip1_sound.play()
		1:
			flip2_sound.play()
		2:
			flip3_sound.play()

func play_heal():
	heal_sound.play()

func play_ignite():
	ignite_sound.play()

func play_shield_equip():
	shield_equip_sound.play()

func play_shield_break():
	shield_break_sound.play()

func toggle_mute(toggled: bool):
	is_muted = !toggled
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled)
