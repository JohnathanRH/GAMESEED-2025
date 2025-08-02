# A mother class for all kinds of enemies.
# NOTE: This class assumes that the enemy that extends it will always have
# an intent_timer and an intent executor. So do not forget to add those to the enemy node always!

extends Sprite2D
class_name EnemyClass

@export var enemy_resource : EnemyResource                             # Open Resource/enemy.gd for more info
@export var next_stage_path : String = "" # for next scene
@export var is_final_enemy : bool = false   # check if it's the final enemy
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile # Open player_save_file.gd for more info

var enemy_intent : int

# Duplicate the enemy resource upon entering the tree
func _enter_tree() -> void:
	enemy_resource = enemy_resource.duplicate()

func _ready() -> void:
	# Initialize timer
	enemy_resource.hpSet.connect(die_check)
	$intent_timer.wait_time = enemy_resource.intent_interval
	$intent_executor.wait_time = $intent_timer.wait_time - 0.1
<<<<<<< HEAD
	
	# Ensure hp is set from max
	# enemy_resource.hp = enemy_resource.MaxHp
	
	# Connect various signals
	$intent_timer.timeout.connect(_on_intent_timer_timeout)
	$intent_executor.timeout.connect(_on_intent_executor_timeout)
	enemy_resource.hpSet.connect(die_check)
	
	# reset the enemy data when restarting the game (doesn't work)
	#reset_data()

# resetting enemy data (doesn't work)
#func reset_data():
#	if enemy_resource:
#		enemy_resource.reset()
=======
	$block_timer.wait_time = enemy_resource.block_duration
	$ability_duration.wait_time = enemy_resource.ability_duration

	# Connect various signals
	$intent_timer.timeout.connect(_on_intent_timer_timeout)
	$intent_executor.timeout.connect(_on_intent_executor_timeout)
	$block_timer.timeout.connect(_on_block_timer_timeout)
	$ability_duration.timeout.connect(_on_ability_duration_timeout)
>>>>>>> d1230d913af5c09050337c753a5eacb076ed32c8

# Death check, this function runs everytime the hp value changes
# If the enemy dies, raise the player stage

func die_check() -> void:
	if(enemy_resource.hp <= 0):
<<<<<<< HEAD
		if is_final_enemy:
			get_tree().change_scene_to_file("res://Gameplay/Stages/Stage Win/scn_win.tscn") # win scene in final stage
		elif next_stage_path != "":
			get_tree().change_scene_to_file(next_stage_path) # go to next stage
			player_save.hp = 10
			player_save.setHp(player_save.hp)
=======
		var newStage = int(player_save.stage)+1
		player_save.setStage(str(newStage))
		PlayerVariables.save_data()
		SceneManager.load_scene("win")
>>>>>>> d1230d913af5c09050337c753a5eacb076ed32c8

# Basic attack that all enemies should have by default
func basic_attack() -> void:
	# Check if player has a shield on
	if player_save.has_shield:
		player_save.setShield(false)
	
	# if not, damage the player
	else:
		player_save.setHp(player_save.hp - enemy_resource.basic_damage)
		AudioManager.play_attack()
		if player_save.hp <= 0:
			get_tree().change_scene_to_file("res://Gameplay/Stages/Stage Lost/scn_lost.tscn") 	

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
	
	# Action pool
	match enemy_intent:
		0: basic_attack()
<<<<<<< HEAD
		1: print("ability")
		2: print("block")
	enemy_intent = randi_range(0, 2) # Pick random number after attacking
	$intent_timer.start() # Restart intent timer to keep behavior ongoing
=======
		1: ability()
		2: block_player_attack()
	
	enemy_intent = randi_range(0, 2)

func _on_block_timer_timeout() -> void:
	enemy_resource.setHasShield(false)

# Is supposed to be empty just like the ability() function
func _on_ability_duration_timeout() -> void:
	pass
>>>>>>> d1230d913af5c09050337c753a5eacb076ed32c8
