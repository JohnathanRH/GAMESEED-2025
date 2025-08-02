extends Node

@onready var player_save: PlayerSaveFile
var enemy: EnemyClass
var enemy_resource: EnemyResource
var current_enemy: EnemyResource

signal attack
signal ignite
signal heal

func register_enemy(stage_enemy: EnemyClass):
	enemy = stage_enemy
	enemy_resource = enemy.enemy_resource
	current_enemy = enemy_resource.duplicate() as EnemyResource
	player_save = PlayerVariables.save_file

func on_match_successful(card_type: String):
	print("signal is connected")
	match card_type:
		"attack":
			damage_enemy(1) # Deals 2 damage
			AudioManager.play_attack()
			emit_signal("attack")
		"fireball":
			damage_enemy(2) # Deals 1 damage
			AudioManager.play_ignite()
			emit_signal("ignite")
		"shield": 
			player_save.setShield(true)  # Activate shield
			AudioManager.play_shield_equip()
			
		"heal":
			player_save.setHp(player_save.hp + 2) # Heals 2 hp
			print(player_save.hp) # debugging
			if player_save.hp >= 10:
				player_save.hp = 10
				player_save.setHp(player_save.hp)
				print(player_save.hp) # debugging
			AudioManager.play_heal()
			emit_signal("heal")
		_:
			return 99

func damage_enemy(amount: int) -> void:
	if(!enemy_resource.has_shield):
		current_enemy.hp -= amount
		print("Enemy takes %d damage. Remaining HP: %d" % [amount, current_enemy.hp])
		enemy_resource.setHP(current_enemy.hp)
		if current_enemy.hp <= 0:
			print("Enemy died!")
	
	else:
		print("Enemy blocked the attack! Enemy has_shield = " + str(enemy_resource.has_shield))
