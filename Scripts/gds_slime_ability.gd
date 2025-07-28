extends Node

@export var from : int
@export var to : int
@export var scale : float

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	$cast_ability.wait_time = randi_range(from, to)

func _on_cast_ability_timeout() -> void:
	GlobalVariables.setCardAnimSpeed(scale)
	$cast_ability.wait_time = randi_range(from, to)


func _on_ability_duration_timeout() -> void:
	GlobalVariables.setCardAnimSpeed(1)
	$cast_ability.start()
