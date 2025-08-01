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
	
	# exclude currently flipped cards or cards that have already been matched
	var cards = GlobalVariables.card_grid.get_children().duplicate() as Array[Button]
	
	for card in cards:
		if(card.is_flipped_up or card.has_matched):
			print("Popped a card: " + str(card))
			cards.erase(card)
	
	# perform the ability
	card_count = cards.size()
	print(card_count, GlobalVariables.card_grid.get_children().size())
	
	for i in amount:
		var random_idx = rng.randi_range(0, card_count-1)
		var selected_card = cards[random_idx]
		selected_card.disabled = true
		selected_card.is_sticky = true
		selected_card.modulate = Color.CHARTREUSE
		affected_cards.append(selected_card)
	
	$ability_duration.start()

func _on_ability_duration_timeout() -> void:
	# return to normal
	for card in affected_cards:
		card.disabled = false
		card.is_sticky = false
		card.modulate = Color(1.0, 1.0, 1.0, 1.0)
	affected_cards.clear()
