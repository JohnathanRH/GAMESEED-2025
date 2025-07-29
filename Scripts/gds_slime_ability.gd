extends Node

@export var from : int
@export var to : int
@export var amount := 4

@onready var card_count = GlobalVariables.card_grid.get_child_count()
@onready var cards = GlobalVariables.card_grid.get_children() as Array[Button]

var rng = RandomNumberGenerator.new()
var affected_cards : Array[Button]

func _ready() -> void:
	$cast_ability.wait_time = randi_range(from, to)

func _on_cast_ability_timeout() -> void:
	# perform the ability
	for i in amount:
		var random_idx = rng.randi_range(0, card_count-1)
		var selected_card = cards[random_idx]
		selected_card.disabled = true
		selected_card.modulate = Color.CHARTREUSE
		affected_cards.append(selected_card)
	
	# randomize the next ability wait time
	$cast_ability.wait_time = randi_range(from, to)
	$ability_duration.start()


func _on_ability_duration_timeout() -> void:
	# return to normal
	for card in affected_cards:
		card.disabled = false
		card.modulate = Color(1.0, 1.0, 1.0, 1.0)
	affected_cards.clear()
