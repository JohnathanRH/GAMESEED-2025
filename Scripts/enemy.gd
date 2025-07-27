extends AnimatedSprite2D

@export var enemy_resource : EnemyResource
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile    # Access the save file thru the autoloader

func _ready() -> void:
	# Enter the data stored in the EnemyResource into whatever requires it
	
	sprite_frames = enemy_resource.animation
	$Timer.wait_time = enemy_resource.atk_interval

func _on_timer_timeout() -> void:
	player_save.setHp(player_save.hp - 1)    # Hard coded damage
