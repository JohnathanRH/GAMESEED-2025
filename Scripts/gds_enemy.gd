extends Sprite2D

@export var enemy_resource: EnemyResource
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile    # Access the save file thru the autoloader
@onready var atk_bar = $"../CanvasLayer/scn_enemy_stats/TextureProgressBar" as TextureProgressBar
@onready var hp_bar = $"../CanvasLayer/scn_enemy_stats/hp_bar" as Label


func _ready() -> void:
	# Enter the data stored in the EnemyResource into whatever requires it
	
	#ssprite_frames = enemy_resource.animation
	$Timer.wait_time = enemy_resource.atk_interval
	atk_bar.max_value = enemy_resource.atk_interval*100

func _process(delta: float) -> void:
	atk_bar.value = $Timer.time_left*100 # <- This controls the smoothness of the progress, less means more snappy
	hp_bar.text = "Enemy HP: " + str(enemy_resource.hp)    # Not optimal, is only temporary
	if(enemy_resource.hp <= 0):
		get_tree().change_scene_to_file("res://Scenes/scn_win.tscn")

func _on_timer_timeout() -> void:
	if player_save.has_shield:
		print("Shield blocked the attack!")
		player_save.setShield(false)  # Shield is used
	else:
		player_save.setHp(player_save.hp - 1)    # Hard coded damage
		if(player_save.hp <= 0):
			get_tree().change_scene_to_file("res://Scenes/scn_lost.tscn")
