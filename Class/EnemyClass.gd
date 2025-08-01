# A mother class for all kinds of enemies.
# NOTE: This class assumes that the enemy that extends it will always have
# an intent_timer and an intent executor. So do not forget to add those to the enemy node always!

extends Sprite2D
class_name EnemyClass

@export var enemy_resource : EnemyResource                             # Open Resource/enemy.gd for more info
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile # Open player_save_file.gd for more info

var enemy_intent : int

func _ready() -> void:
	# Initialize timer
	$intent_timer.wait_time = enemy_resource.intent_interval
	
	# Connect various signals
	$intent_timer.timeout.connect(_on_intent_timer_timeout)
	$intent_executor.timeout.connect(_on_intent_executor_timeout)
	enemy_resource.hpSet.connect(die_check)

# Death check, this function runs everytime the hp value changes
func die_check() -> void:
	if(enemy_resource.hp <= 0):
		get_tree().change_scene_to_file("res://Gameplay/Stages/Stage Win/scn_win.tscn")

# Basic attack that all enemies should have by default
func basic_attack() -> void:
	# Check if player has a shield on
	if player_save.has_shield:
		player_save.setShield(false)
	
	# if not, damage the player
	else:
		player_save.setHp(player_save.hp - enemy_resource.basic_damage)

func block_player_attack() -> void:
	pass # Pending block attack system design

# Since abilities are unique, enemies should override this method in their own script
func ability() -> void:
	pass

func _on_intent_timer_timeout() -> void:
	enemy_intent = randi_range(0, 2)
	$intent_executor.start()

# Execute the intent.
func _on_intent_executor_timeout() -> void:
	match enemy_intent:
		0: basic_attack()
		1: print("ability")
		2: print("block")
	
	$intent_timer.start()
