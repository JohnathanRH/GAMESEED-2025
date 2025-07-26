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

func shuffleCard():
	addCard()
	
	deck.shuffle()
	
	
func _ready() -> void:
	shuffleCard()
	
	$VBoxContainer.scale = Vector2(grid_scale, grid_scale)
	var grid = preload("res://Scenes/Component/scn_card_grid.tscn").instantiate()
	grid.columns = grid_size
	grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	$VBoxContainer.add_child(grid)
	
	
	var it = 0;
	var grid_pow = grid_size*grid_size
	for type in deck:
		if it >= grid_pow:
			break
		var addCard = preload("res://Scenes/Component/scn_card_placeholder.tscn").instantiate()
		addCard.card_type = type
		grid.add_child(addCard)
		it += 1
			
	
	pass
