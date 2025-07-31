extends Control

@export var check_time := 0.2 # its probably better to + this with the animation time to offset this wait time.

@export var grid_size = 5
@export var grid_scale: float = 1
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile

# Card Shuffle Variable
var card2p = ["attack", "fireball", "shield"]
var card3p = ["heal"]
@export var deck = []
var grid = preload("res://Scenes/Component/scn_card_grid.tscn").instantiate()

## 2x + 3y = grid_size*grid_size
@export var x = 11
@export var y = 1
@onready var card_layout = $VBoxContainer

# Card Matching Variable
var required_match = 0
var matches = {}
var currently_flipped_card = []
var match_card_type = ""
var matched_card = []
var matched_card_type = []
@onready var mismatch_timer = $MismatchTimer
@onready var match_timer = $MatchTimer

# Enemy
@export var enemy_resource: EnemyResource
var current_enemy: EnemyResource

# keep track how many card matched
var pair_matched: int = 0:
	set(add_pair):
		pair_matched = add_pair 
		print("current matched pair: ", pair_matched)
		if(pair_matched >= x+y):
			$ShuffleTimer.start(check_time*2)
			

# Add card into deck
func add_card():
	for type in card2p:
		if(type == "shield"):
			for i in range(3):
				deck.append(type)
				deck.append(type)
		else:
			for i in range(4):
				deck.append(type)
				deck.append(type)
	for j in range(y):
		deck.append(card3p[j%card3p.size()])
		deck.append(card3p[j%card3p.size()])
		deck.append(card3p[j%card3p.size()])


# shuffle card on the deck
func shuffle_card():
	add_card()
	randomize()
	deck.shuffle()

func display_card():
	card_layout.scale = Vector2(grid_scale, grid_scale)
	
	grid.columns = grid_size
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

func _ready() -> void:
	# Initalize Enemy
	if enemy_resource:
		current_enemy = enemy_resource.duplicate() as EnemyResource
		print("Enemy HP: %d" % current_enemy.hp)
		for i in deck:
			print("this is are the deck : ", i)
	
	GlobalVariables.is_checking_match = false
	
	shuffle_card()
	display_card()
	grid.shuffle_children()


# Logic when function selected
func _on_card_selected(card_type: String, card_node: Node):
	if GlobalVariables.is_checking_match or card_node.is_flipped_up: # check if card is on checking or flipped up
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
			GlobalVariables.is_checking_match = true
			card_node.flip_up() # flip up the card
			currently_flipped_card.append(card_node)
			mismatch_timer.start(check_time) # flip down the card after pause time
			return
		
		card_node.flip_up() # flip up the card
		currently_flipped_card.append(card_node) # track flipped up card
	
	# if the number of currently flipped up card equal to required match
	if currently_flipped_card.size() == required_match: # check if the match card are succesfull
		GlobalVariables.is_checking_match = true
		process_successfull_match(card_type, currently_flipped_card)
		currently_flipped_card.clear() # clear the track of flipped up card
		
		required_match = 0 # reset the required match
		GlobalVariables.is_checking_match = false

# process the succesfull match
func process_successfull_match(card_type: String, matches_card: Array):
	if not matches.has(card_type):
		matches[card_type] = []
	matches[card_type].append_array(matches_card)
	var required_pair = get_match_size(card_type)
	var current_card_size = matches[card_type].size()
	
	# Record pair matched, and start the match timer
	if current_card_size >= required_pair:
		match_card_type = card_type
		match_timer.start(check_time)
		pair_matched += 1
		
		for card in matches[card_type]:
			matched_card.append(card)
			matches.erase(match_card_type)
			card.has_matched = true
			print(card)
		
		matched_card_type.append(match_card_type)
		match_card_type = ""	

# DENAR THIS IS YOUR JOB GO DO YOUR THING
func use_card(card_type: String):
	match card_type:
		"attack":
			damage_enemy(1) # Deals 2 damage
		"fireball":
			damage_enemy(2) # Deals 1 damage
		"shield": 
			player_save.setShield(true)  # Activate shield
			print("Used Shield")
		"heal":
			player_save.setHp(player_save.hp + 2) # Heals 2 hp
			print(player_save.hp) # debugging
			if player_save.hp >= 10:
				player_save.hp = 10
				player_save.setHp(10)
				print(player_save.hp) # debugging
		_:
			return 99

func damage_enemy(amount: int) -> void:
	current_enemy.hp -= amount
	print("Enemy takes %d damage. Remaining HP: %d" % [amount, current_enemy.hp])
	enemy_resource.setHP(current_enemy.hp)
	if current_enemy.hp <= 0:
		print("Enemy died!")

	
func get_match_size(card_type: String) -> int:
	match card_type:
		"attack", "fireball", "shield":
			return 2
		"heal":
			return 3
		_:
			return 99

func _on_timer_timeout() -> void:
	for card in currently_flipped_card:
		card.flip_down()
	
	currently_flipped_card.clear()
	required_match = 0
	GlobalVariables.is_checking_match = false

func _on_match_timer_timeout() -> void:
		for card_type in matched_card_type:
			use_card(card_type)
		matched_card_type.clear()
		for card in matched_card:
			card.modulate.a = 0
			card.disabled = true
			card.flip_down()
		matched_card.clear()
		


func _on_shuffle_timer_timeout() -> void:
	grid.shuffle_children()
	pair_matched = 1
