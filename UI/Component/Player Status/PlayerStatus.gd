extends Node

@onready var player_save = PlayerVariables.save_file as PlayerSaveFile    # Get the player save file thru the autoloader
@onready var player_hp = player_save.hp

func _ready() -> void:
	# Setup the ui upon entering the scene
	$player_name.text = player_save.name
	update_hp()
	
	# Connect these signals to detect changes on the respective attributes. (example: receiving damage)
	player_save.hpSet.connect(update_hp)
	player_save.shieldSet.connect(update_shield)
	
func update_shield() -> void:
	$shield_icon.visible = player_save.has_shield

# Functions to update the ui
func update_hp() -> void:
	$hp.text = str(player_save.hp) + "/" + str(player_hp)
