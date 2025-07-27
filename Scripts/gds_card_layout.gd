extends Control

@export var grid_size = 5
@export var grid_scale: float = 1

var card2p = ["attack", "fireball"]
var card3p = ["heal", "shield"]
var deck = []

var required_match = 0
var matches = {}
var currently_flipped_card = []
var is_checking_match = false
@onready var mismatch_timer = $Timer

func addCard():
	while deck.size() < grid_size*grid_size:
		for type in card2p:
			deck.append(type)
			deck.append(type)
	
		for type in card3p:
			deck.append(type)
			deck.append(type)
			deck.append(type)

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
		var addCard = preload("res://Scenes/Component/scn_card.tscn").instantiate()
		addCard.card_type = type
		addCard.card_selected.connect(_on_card_selected)
		grid.add_child(addCard)
		it += 1
			
	
	pass

func _on_card_selected(card_type: String, card_node: Node):
	if is_checking_match or card_node.is_flipped_up:
		return
	
	if currently_flipped_card.is_empty():
		required_match = get_match_size(card_type)
		print("Starting a new turn. Need to find ", required_match, " '", card_type, "' cards.")
		
		card_node.flip_up()
		currently_flipped_card.append(card_node)
	else:
		var first_card_type = currently_flipped_card[0].card_type
		
		if card_type != first_card_type:
			print("Wrong type! Expected '", first_card_type, "' but got '", card_type, "'.")
			is_checking_match = true
			card_node.flip_up()
			currently_flipped_card.append(card_node)
			mismatch_timer.start(1.2)
			return
		
		card_node.flip_up()
		currently_flipped_card.append(card_node)
		
	if currently_flipped_card.size() == required_match:
		is_checking_match = true
		print("Successful memory match for type: ", card_type)
		process_successfull_match(card_type, currently_flipped_card)
		currently_flipped_card.clear()
		
		required_match = 0
		is_checking_match = false
		

func process_successfull_match(card_type: String, matches_card: Array):
	if not matches.has(card_type):
		matches[card_type] = []
	matches[card_type].append_array(matches_card)
	
	var required_pair = get_match_size(card_type)
	var current_card_size = matches[card_type].size()
	if current_card_size >= required_pair:
		use_card(card_type)
		for card in matches[card_type]:
			card.modulate.a = 0
			card.disabled = true
		matches.erase(card_type)
	

func use_card(card_type: String):
	match card_type:
		"attack":
			print("Use Attack")
		"fireball":
			print("Use Fireball")
		"shield": 
			print("Use Shield")
		"heal":
			print("Use Heal")
		_:
			return 99
	pass

func get_match_size(card_type: String) -> int:
	match card_type:
		"attack", "fireball":
			return 2
		"shield", "heal":
			return 3
		_:
			return 99

func _on_timer_timeout() -> void:
	for card in currently_flipped_card:
		card.flip_down()
	
	currently_flipped_card.clear()
	required_match = 0
	is_checking_match = false
	pass # Replace with function body.
