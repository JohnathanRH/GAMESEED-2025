extends Sprite2D

@export var enemy_resource: EnemyResource
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile    # Access the save file thru the autoloader
@onready var enemy_stat = $"../CanvasLayer/scn_enemy_stats"
var atk_bar : TextureProgressBar
var atk_orb : TextureProgressBar
var hp_bar: TextureProgressBar
var hp_label : Label
var intent_icon : Sprite2D
@onready var enemy_hp = enemy_resource.hp

func _ready() -> void:
	# Enter the data stored in the EnemyResource into whatever requires it
	randomize()
	$Timer.wait_time = enemy_resource.atk_interval
	atk_bar = enemy_stat.get_child(0)
	hp_label = enemy_stat.get_child(1)
	atk_orb = enemy_stat.get_child(2)
	hp_bar = enemy_stat.get_child(3)
	intent_icon = enemy_stat.get_child(4)
	
	atk_bar.max_value = enemy_resource.atk_interval*100
	hp_bar.max_value = enemy_hp
	hp_bar.value = enemy_resource.hp

func _process(delta: float) -> void:
	atk_bar.value = atk_bar.max_value - ($Timer.time_left*100)
	hp_label.text = str(enemy_resource.hp) + "/" + str(enemy_hp)     # Not optimal, is only temporary
	hp_bar.value = enemy_resource.hp
	if(enemy_resource.hp <= 0):
		get_tree().change_scene_to_file("res://Scenes/scn_win.tscn")

func _on_timer_timeout() -> void:
	atk_orb.value = 1
	$orb_timer.start()
	var enemy_atk = randi_range(0, 2)
	match enemy_atk:
		# Perform Basic attack
		0:
			intent_icon.texture = load("res://Assets/Card/SymbolSword.png")
			if player_save.has_shield:
				print("Shield blocked the attack!")
				player_save.setShield(false)  # Shield is used
			else:
				player_save.setHp(player_save.hp - 1)    # Hard coded damage
				if(player_save.hp <= 0):
					get_tree().change_scene_to_file("res://Scenes/scn_lost.tscn")
		
		# Perform ability
		1:
			$slime_ability.cast_ability()    # Hard coded ability. this code now assumes this 'enemy' node have a slime_ability
			intent_icon.texture = load("res://Assets/Card/SymbolFire.png")
			print("ability")
		
		# Defend
		2:
			intent_icon.texture = load("res://Assets/Card/SymbolShield.png")
			print("block")
	intent_icon.visible = true


func _on_orb_timer_timeout() -> void:
	atk_orb.value = 0
	#intent_icon.visible = false
