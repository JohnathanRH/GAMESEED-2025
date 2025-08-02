extends Resource
class_name PlayerSaveFile

@export var name : String
@export var hp : int
@export var stage : String #Placeholder
@export var level : int # Player level
@export var has_shield: bool = false 

# Signals to detect changed stats
signal nameSet
signal hpSet
signal levelSet
signal shieldSet
signal stageSet

# Setter functions, no need for getters for now
func setName(newName : String) -> void:
	name = newName
	nameSet.emit()

func setHp(newHp : int) -> void:
	hp = newHp
	hpSet.emit()

func setLevel(newLevel : int) -> void:
	level = newLevel
	levelSet.emit()

func setShield(newShield: bool) -> void:
	has_shield = newShield
	shieldSet.emit()

func setStage(newStage : String) -> void:
	stage = newStage
	stageSet.emit()
