# The data used by a specific enemy
extends Resource
class_name EnemyResource

#@export var animation : SpriteFrames
@export var hp : int
@export var intent_interval : float
@export var basic_damage : float

#@export var MaxHp: int = 10 # max hp for enemy stat resets (doesn't work)

signal hpSet

func setHP(newHP: int) ->void:
	hp = newHP
	hpSet.emit()

#func reset():
#	hp = MaxHp
