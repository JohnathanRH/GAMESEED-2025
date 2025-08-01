# The data used by a specific enemy
extends Resource
class_name EnemyResource

#@export var animation : SpriteFrames
@export var hp : int
@export var intent_interval : float
@export var basic_damage : float

signal hpSet

func setHP(newHP: int) ->void:
	hp = newHP
	hpSet.emit()
