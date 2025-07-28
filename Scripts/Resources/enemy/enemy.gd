extends Resource
class_name EnemyResource

@export var animation : SpriteFrames
@export var hp : int
@export var atk_interval : float

func setHP(newHP: int) ->void:
	hp = newHP
	
