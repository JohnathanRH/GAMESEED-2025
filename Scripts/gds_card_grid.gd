extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	shuffle_children()

func shuffle_children():
	
	var children = get_children()
	
	children.shuffle()
	
	for child in children:
		child.modulate.a = 1
		child.disabled = false
		remove_child(child)
		add_child(child)
		move_child(child, -1)
	pass
