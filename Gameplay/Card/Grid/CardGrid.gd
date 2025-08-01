extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.card_grid = self
	randomize()

func shuffle_children():
	
	var children = get_children()
	
	children.shuffle()
	
	for child in children:
		child.modulate.a = 1
		child.disabled = false
		child.has_matched = false
		child.is_flipped_up = false
		remove_child(child)
		add_child(child)
		move_child(child, -1)
	for child in children:
		child.condensing()
	pass
