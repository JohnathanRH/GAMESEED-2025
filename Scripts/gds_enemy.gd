extends Sprite2D

@export var enemy_resource: EnemyResource
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile    # Access the save file thru the autoloader
@onready var enemy_stat = $"../CanvasLayer/scn_enemy_stats"
var atk_bar : TextureProgressBar
var atk_orb : TextureProgressBar
var hp_bar: TextureProgressBar
var hp_label : Label
@onready var enemy_hp = enemy_resource.hp

func _ready() -> void:
	# Enter the data stored in the EnemyResource into whatever requires it
	
	#ssprite_frames = enemy_resource.animation
	$Timer.wait_time = enemy_resource.atk_interval
	atk_bar = enemy_stat.get_child(0)
	hp_label = enemy_stat.get_child(1)
	atk_orb = enemy_stat.get_child(2)
	hp_bar = enemy_stat.get_child(3)
	atk_bar.max_value = enemy_resource.atk_interval*100
	hp_bar.max_value = enemy_hp
	hp_bar.value = enemy_resource.hp

func _process(delta: float) -> void:
	atk_bar.value = atk_bar.max_value - ($Timer.time_left*100) # <- This controls the smoothness of the progress, less means more snappy
	hp_label.text = str(enemy_resource.hp) + "/" + str(enemy_hp)     # Not optimal, is only temporary
	hp_bar.value = enemy_resource.hp
	if(enemy_resource.hp <= 0):
		get_tree().change_scene_to_file("res://Scenes/scn_win.tscn")

func _on_timer_timeout() -> void:
	atk_orb.value = 1
	$orb_timer.start()
	if player_save.has_shield:
		print("Shield blocked the attack!")
		player_save.setShield(false)  # Shield is used
	else:
		player_save.setHp(player_save.hp - 1)    # Hard coded damage
		if(player_save.hp <= 0):
			get_tree().change_scene_to_file("res://Scenes/scn_lost.tscn")


func _on_orb_timer_timeout() -> void:
	atk_orb.value = 0
	
