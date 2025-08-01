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

signal hpSet
signal hasShieldSet

func setHP(newHP: int) ->void:
	hp = newHP
	hpSet.emit()

func setHasShield(newShield : bool):
	has_shield = newShield
	hasShieldSet.emit()
