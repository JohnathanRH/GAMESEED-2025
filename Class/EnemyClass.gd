# A mother class for all kinds of enemies.
# NOTE: This class assumes that the enemy that extends it will always have
# an intent_timer and an intent executor. So do not forget to add those to the enemy node always!

extends Sprite2D
class_name EnemyClass

@export var enemy_resource : EnemyResource                             # Open Resource/enemy.gd for more info
@export_enum("1", "2", "3", "4", "5", "win", "lose") var next_stage_path : String = "1"
@export var is_final_enemy : bool = false   # check if it's the final enemy
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile # Open player_save_file.gd for more info

var enemy_intent : int

# Duplicate the enemy resource upon entering the tree
func _enter_tree() -> void:
	enemy_resource = enemy_resource.duplicate()

func _ready() -> void:
	# Initialize timers
	$intent_timer.wait_time = enemy_resource.intent_interval
	$intent_executor.wait_time = $intent_timer.wait_time - 0.1
	$block_timer.wait_time = enemy_resource.block_duration
	$ability_duration.wait_time = enemy_resource.ability_duration

	# Connect various signals
	$intent_timer.timeout.connect(_on_intent_timer_timeout)
	$intent_executor.timeout.connect(_on_intent_executor_timeout)
	$block_timer.timeout.connect(_on_block_timer_timeout)
	$ability_duration.timeout.connect(_on_ability_duration_timeout)
	enemy_resource.hpSet.connect(die_check)

# Death check, this function runs every time the hp value changes
func die_check() -> void:
	if enemy_resource.hp <= 0:
		if is_final_enemy:
			SceneManager.load_scene("win") # win scene in final stage
		elif !is_final_enemy:
			SceneManager.load_scene(next_stage_path) # go to next stage
			player_save.hp = 10
			player_save.setHp(player_save.hp)
		else:
			var newStage = int(player_save.stage) + 1
			player_save.setStage(str(newStage))
			PlayerVariables.save_data()
			SceneManager.load_scene("win")

# Basic attack that all enemies should have by default
func basic_attack() -> void:
	# Check if player has a shield on
	if player_save.has_shield:
		player_save.setShield(false)
		AudioManager.play_shield_break()
	else:
		player_save.setHp(player_save.hp - enemy_resource.basic_damage)
		AudioManager.play_attack()
		if player_save.hp <= 0:
			SceneManager.load_scene("lose")

func block_player_attack() -> void:
	enemy_resource.setHasShield(true)
	$block_timer.start()

# Since abilities are unique, enemies should override this method in their own script
func ability() -> void:
	pass

func _on_intent_timer_timeout() -> void:
	$intent_executor.start()

# Execute the intent.
func _on_intent_executor_timeout() -> void:
	match enemy_intent:
		0: basic_attack()
		1: ability()
		2: block_player_attack()

	enemy_intent = randi_range(0, 2)
	$intent_timer.start()

func _on_block_timer_timeout() -> void:
	enemy_resource.setHasShield(false)

# Is supposed to be empty just like the ability() function
func _on_ability_duration_timeout() -> void:
	pass
