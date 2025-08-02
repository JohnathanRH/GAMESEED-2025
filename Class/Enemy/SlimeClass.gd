extends EnemyClass
class_name SlimeClass


@export var amount := 1
var affected_cards : Array[Button]

# Custom ability unique to this slime
func ability() -> void:
	AudioManager.play_attack()
	
	# Get all of the cards
	var cards = GlobalVariables.card_grid.get_children().duplicate() as Array[Button]
	
	# Eliminate marked cards  from the card pool (flipped cards or matched cards)
	for card in cards.duplicate():
		if(card.is_flipped_up or card.has_matched):
			cards.erase(card)
	
	randomize()
	
	var card_count = cards.size()
	
	# if theres only 8 card left, restrict the amount that can be affected to 1
	if (card_count < 8):
		amount = 1
	
	# Prevent the ability if card count is <= 4
	if (card_count > 4):
		
		# For ... amount of cards, pick one random card and disable it, also make it green
		for i in amount:
			var random_idx = randi_range(0, card_count-1)
			var selected_card = cards[random_idx]
			selected_card.disabled = true
			selected_card.modulate = Color.CHARTREUSE
			affected_cards.append(selected_card)
	
	$ability_duration.start()

# Return to normal and reset affected cards array
func _on_ability_duration_timeout() -> void:
	for card in affected_cards:
		card.disabled = false
		card.modulate = Color(1.0, 1.0, 1.0, 1.0)
	affected_cards.clear()
