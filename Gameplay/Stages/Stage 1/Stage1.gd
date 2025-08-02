extends Node2D

# No use for this at the moment
# Safe to delete
var player_side_vfx: Sprite2D
var enemy_side_vfx: Sprite2D

func _ready() -> void:
	$Panel/ScnPauseMenu.option_pressed.connect(on_option_button_pressed)
	PlayerActionManager.attack.connect(on_player_attacking)
	PlayerActionManager.ignite.connect(on_player_ignite)
	PlayerActionManager.heal.connect(on_player_heal)
	
	$enemy.attack.connect(on_enemy_attack)
	$enemy.slime_ability.connect(on_slime_ability)
	
	player_side_vfx = $Container/player/ScnAttackVfx
	enemy_side_vfx = $enemy/ScnAttackVfx
	
func on_option_button_pressed():
	$OptionMenu.visible = true

func on_player_attacking():
	enemy_side_vfx.play_attack()

func on_player_ignite():
	enemy_side_vfx.play_ignite()

func on_player_heal():
	player_side_vfx.play_heal()
	
func on_enemy_attack():
	player_side_vfx.play_attack()
	
func on_slime_ability():
	player_side_vfx.play_slime_ability()
