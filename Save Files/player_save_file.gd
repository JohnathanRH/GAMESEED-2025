extends Resource
class_name PlayerSaveFile

@export var name : String
@export var hp : int
@export var stage : String #Placeholder
@export var level : int # Player level


# Signals to detect changed stats
signal nameSet
signal hpSet
signal levelSet

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
