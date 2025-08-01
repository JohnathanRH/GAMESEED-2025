extends Control

@onready var check_time := GlobalVariables.check_time # its probably better to + this with the animation time to offset this wait time.

@export var grid_size = 5
@export var grid_scale: float = 1
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile

# Card Shuffle Variable
var card2p = ["attack", "fireball", "shield"]
var card3p = ["heal"]
@export var deck = []
var grid = preload("res://Gameplay/Card/Grid/scn_card_grid.tscn").instantiate()

## 2x + 3y = grid_size*grid_size
@export var num_of_2_pair_card = 11
@export var num_of_3_pair_card = 1
@onready var card_layout = $VBoxContainer

# Card Matching Variable
var required_match = 0
var matches = {}
var currently_flipped_card = []
var match_card_type = ""
#var matched_card = []
var matched_card_type = []
@onready var mismatch_timer = $MismatchTimer
@onready var match_timer = $MatchTimer
signal match_successful(card_type)
enum State { IDLE, AWAITING_SECOND_CARD, CHECKING }


# keep track how many card matched
var pair_matched: int = 0:
	set(add_pair):
		pair_matched = add_pair 
		print("current matched pair: ", pair_matched)
		if(pair_matched >= num_of_2_pair_card+num_of_3_pair_card):
			$ShuffleTimer.start()
			

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
	for j in range(num_of_3_pair_card):
		deck.append(card3p[j%card3p.size()])
		deck.append(card3p[j%card3p.size()])
		deck.append(card3p[j%card3p.size()])

func display_card():
	add_card()
	card_layout.scale = Vector2(grid_scale, grid_scale)
	
	grid.columns = grid_size
	card_layout.add_child(grid)
	
	for type in deck:
		var addCard = preload("res://Gameplay/Card/scn_card.tscn").instantiate()
		addCard.card_type = type
		addCard.card_selected.connect(_on_card_selected)
		grid.add_child(addCard)

func _ready() -> void:
	PlayerActionManager.register_enemy(self.get_tree().get_first_node_in_group("enemy"))

	self.match_successful.connect(PlayerActionManager.on_match_successful)

	GlobalVariables.current_state = State.IDLE
	GlobalVariables.check_time_changed.connect(_on_check_time_changed)

	display_card()
	grid.shuffle_children()
	


# Logic when function selected
func _on_card_selected(card_type: String, card_node: Node):
	match GlobalVariables.current_state:
		State.IDLE:
			required_match = get_match_size(card_type) # set the required match
		
			card_node.flip_up()
			currently_flipped_card.append(card_node)
			GlobalVariables.current_state = State.AWAITING_SECOND_CARD
		State.AWAITING_SECOND_CARD:
			print("hallo")
			var first_card_type = currently_flipped_card[0].card_type
		
			# if the card is not the same type 
			if card_type != first_card_type: # give a pause and flip down the card
				GlobalVariables.current_state = State.CHECKING
				card_node.flip_up() # flip up the card
				currently_flipped_card.append(card_node)
				mismatch_timer.start(check_time) # flip down the card after pause time
				return
		
			card_node.flip_up() # flip up the card
			currently_flipped_card.append(card_node) # track flipped up card
			
			if currently_flipped_card.size() == required_match: # check if the match card are succesfull
				GlobalVariables.current_state = State.CHECKING
				matched_card_type.append(card_type)
				#process_successfull_match(card_type, currently_flipped_card)
				match_timer.start(check_time)
				pair_matched += 1
				#currently_flipped_card.clear() # clear the track of flipped up card
		
				required_match = 0 # reset the required match
				
		State.CHECKING:
			pass

	
# this is a security if some bug appear on the future
# process the succesfull match
#func process_successfull_match(card_type: String, matches_card: Array):
	#if not matches.has(card_type):
		#matches[card_type] = []
	#matches[card_type].append_array(matches_card)
	#var required_pair = get_match_size(card_type)
	#var current_card_size = matches[card_type].size()
	#
	## Record pair matched, and start the match timer
	#if current_card_size >= required_pair:
		#match_card_type = card_type
		#match_timer.start(check_time)
		#pair_matched += 1
		#
		#for card in matches[card_type]:
			#matched_card.append(card)
			#matches.erase(match_card_type)
			#card.has_matched = true
			##print(card)
		#
		#matched_card_type.append(match_card_type)
		#match_card_type = ""	


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
	GlobalVariables.current_state = State.IDLE

func _on_match_timer_timeout() -> void:
		print("match timeout")
		for card_type in matched_card_type:
			emit_signal("match_successful", card_type)
		matched_card_type.clear()
		for card in currently_flipped_card:
			#card.modulate = 0
			card.has_matched = true
			card.flip_down()
			
		for card in currently_flipped_card:
			card.disabled = true
		currently_flipped_card.clear()
		GlobalVariables.current_state = State.IDLE

func _on_shuffle_timer_timeout() -> void:
	grid.shuffle_children()
	pair_matched = 0

func _on_check_time_changed(value: float):
	check_time = value
