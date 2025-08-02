# The data used by a specific enemy
extends Resource
class_name EnemyResource

# Data fields
@export var hp : int
@export var intent_interval : float
@export var basic_damage : float
@export var block_duration : float
@export var ability_duration : float

var has_shield := false

# Signals
signal hpSet
signal hasShieldSet

# Set HP and emit signal
func setHP(newHP: int) -> void:
	hp = newHP
	hpSet.emit()

# Set shield status and emit signal
func setHasShield(newShield: bool) -> void:
	has_shield = newShield
	hasShieldSet.emit()

# Optional: Reset method placeholder (not currently used)
#@export var MaxHp: int = 10
#func reset():
#	hp = MaxHp
