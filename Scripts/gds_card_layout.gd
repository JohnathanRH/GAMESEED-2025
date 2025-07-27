extends Control

@export var grid_size = 5
@export var grid_scale: float = 1

var card2p = ["attack", "fireball", "heal", "shield"]
var card3p = ["heal", "shield"]
var deck = []

func addCard():
	while deck.size() < grid_size*grid_size:
		for type in card2p:
			deck.append(type)
			deck.append(type)
	
		for type in card3p:
			deck.append(type)
			deck.append(type)
			deck.append(type)

var selected_cards: Array = []
var matched_pairs := 0

func shuffleCard():
	addCard()
	deck.shuffle()
	
	
func _ready() -> void:
	shuffleCard()
	
	$VBoxContainer.scale = Vector2(grid_scale, grid_scale)
	var grid = preload("res://Scenes/Component/scn_card_grid.tscn").instantiate()
	grid.columns = grid_size
	#grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	$VBoxContainer.add_child(grid)
	
	
	var it = 0;
	var grid_pow = grid_size*grid_size
	for type in deck:
		if it >= grid_pow:
			break
		var addCard = preload("res://Scenes/Component/scn_card_placeholder.tscn").instantiate()
		addCard.card_type = type
		addCard.card_selected.connect(_on_card_selected)
		grid.add_child(addCard)
		it += 1
			
	
	pass

func _on_card_selected(card_type: String, card_node: Node):
	# Selection Logic
	if selected_cards.has(card_node):
		selected_cards.erase(card_node)
		card_node.set_selected(false)
		matched_pairs = max(matched_pairs - 1, 0)
		return
	
	# Select cards
	selected_cards.append(card_node)
	card_node.set_selected(true)

	if selected_cards.size() >= 2:
		var card1 = selected_cards[-2]
		var card2 = selected_cards[-1]

		if card1.card_type == card2.card_type:
			matched_pairs += 1
			var cost = get_card_cost(card1.card_type)

			if matched_pairs >= cost:
				apply_card_effect(card1.card_type)
				for card in selected_cards:
					card.modulate.a = 0
					card.process_mode = Node.PROCESS_MODE_DISABLED
					card.mouse_filter = Control.MOUSE_FILTER_IGNORE
				selected_cards.clear()
		else:
			selected_cards.clear()

func _clear_selected_cards():
	for card in selected_cards:
		card.set_selected(false)
	selected_cards.clear()
	matched_pairs = 0

func get_card_cost(card_type: String) -> int:
	match card_type:
		"attack", "fireball":
			return 1
		"heal", "shield":
			return 2
		_:
			return 99

func apply_card_effect(card_type: String):
	match card_type:
		"attack":
			print("Attack: Deal 1 damage")
		"fireball":
			print("Fireball: Deal 2 damage")
		"heal":
			print("Heal: Restore 2 HP")
		"shield":
			print("Shield: Block an Attack")
