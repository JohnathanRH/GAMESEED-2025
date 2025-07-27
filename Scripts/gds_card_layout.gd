extends Control

@export var grid_size = 5
@export var grid_scale: float = 1

# Card Shuffle Variable
var card2p = ["attack", "fireball"]
var card3p = ["heal", "shield"]
var deck = []
@onready var card_layout = $VBoxContainer

# Card Matching Variable
var required_match = 0
var matches = {}
var currently_flipped_card = []
var is_checking_match = false
var match_card_type = ""
@onready var mismatch_timer = $MismatchTimer
@onready var match_timer = $MatchTimer



# Add card into deck
func addCard():
	while deck.size() < grid_size*grid_size:
		for type in card2p:
			deck.append(type)
			deck.append(type)
	
		for type in card3p:
			deck.append(type)
			deck.append(type)
			deck.append(type)

# shuffle card on the deck
func shuffleCard():
	addCard()
	deck.shuffle()


func _ready() -> void:
	shuffleCard()
	
	card_layout.scale = Vector2(grid_scale, grid_scale)
	var grid = preload("res://Scenes/Component/scn_card_grid.tscn").instantiate()
	grid.columns = grid_size
	#grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	card_layout.add_child(grid)
	
	
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

# Logic when function selected
func _on_card_selected(card_type: String, card_node: Node):
	if is_checking_match or card_node.is_flipped_up: # check if card is on checking or flipped up
		return
	
	# if the card that currently flipped up is empty
	if currently_flipped_card.is_empty(): # Start a new turn
		required_match = get_match_size(card_type) # set the required match
		
		card_node.flip_up()
		currently_flipped_card.append(card_node)
	else: # Continue the existing turn
		var first_card_type = currently_flipped_card[0].card_type
		
		# if the card is not the same type 
		if card_type != first_card_type: # give a pause and flip down the card
			is_checking_match = true
			card_node.flip_up() # flip up the card
			currently_flipped_card.append(card_node)
			mismatch_timer.start(1.2) # flip down the card after pause time
			return
		
		card_node.flip_up() # flip up the card
		currently_flipped_card.append(card_node) # track flipped up card
	
	# if the number of currently flipped up card equal to required match
	if currently_flipped_card.size() == required_match: # check if the match card are succesfull
		is_checking_match = true
		process_successfull_match(card_type, currently_flipped_card)
		currently_flipped_card.clear() # clear the track of flipped up card
		
		required_match = 0 # reset the required match
		is_checking_match = false

# process the succesfull match
func process_successfull_match(card_type: String, matches_card: Array):
	if not matches.has(card_type):
		matches[card_type] = []
	matches[card_type].append_array(matches_card)
	
	var required_pair = get_match_size(card_type)
	var current_card_size = matches[card_type].size()
	if current_card_size >= required_pair:
		match_card_type = card_type
		match_timer.start(1.2)

# DENAR THIS IS YOUR JOB GO DO YOUR THING
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


func _on_match_timer_timeout() -> void:
		use_card(match_card_type)
		for card in matches[match_card_type]:
			card.modulate.a = 0
			card.disabled = true
		matches.erase(match_card_type)
		match_card_type = ""
