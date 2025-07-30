extends Node
class_name SlimeAbility

@export var from : int
@export var to : int
@export var amount := 4

@onready var card_count : int

var rng = RandomNumberGenerator.new()
var affected_cards : Array[Button]

func cast_ability() -> void:
	# Reset the affected card (This is a funny way to do it lmao)
	$ability_duration.timeout.emit()
	
	# perform the ability
	card_count = GlobalVariables.available_cards.size()
	
	for i in amount:
		var random_idx = rng.randi_range(0, card_count-1)
		var selected_card = GlobalVariables.available_cards[random_idx]
		selected_card.disabled = true
		selected_card.modulate = Color.CHARTREUSE
		affected_cards.append(selected_card)
	
	$ability_duration.start()


func _on_ability_duration_timeout() -> void:
	# return to normal
	for card in affected_cards:
		card.disabled = false
		card.modulate = Color(1.0, 1.0, 1.0, 1.0)
	affected_cards.clear()
