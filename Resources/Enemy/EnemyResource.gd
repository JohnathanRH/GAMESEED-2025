# The data used by a specific enemy
extends Resource
class_name EnemyResource

#@export var animation : SpriteFrames
@export var hp : int
@export var intent_interval : float
@export var basic_damage : float
@export var block_duration : float
@export var ability_duration : float

var has_shield := false

#@export var MaxHp: int = 10 # max hp for enemy stat resets (doesn't work)

signal hpSet
signal hasShieldSet

func setHP(newHP: int) ->void:
	hp = newHP
	hpSet.emit()

<<<<<<< HEAD
#func reset():
#	hp = MaxHp
=======
func setHasShield(newShield : bool):
	has_shield = newShield
	hasShieldSet.emit()
>>>>>>> d1230d913af5c09050337c753a5eacb076ed32c8
