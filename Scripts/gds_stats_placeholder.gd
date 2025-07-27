extends Node

@onready var player_save = PlayerVariables.save_file as PlayerSaveFile    # Get the player save file thru the autoloader

func _ready() -> void:
	# Setup the ui upon entering the scene
	$player_name.text = "Player Name: " + player_save.name
	update_hp()
	update_level()
	
	# Connect these signals to detect changes on the respective attributes. (example: receiving damage)
	player_save.hpSet.connect(update_hp)
	player_save.levelSet.connect(update_level)

# Functions to update the ui
func update_hp() -> void:
	$hp.text = "Player HP: " + str(player_save.hp)

func update_level() -> void:
	$level.text = "Player Level: " + str(player_save.level)
