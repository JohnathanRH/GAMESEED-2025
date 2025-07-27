extends TextureButton

@export var card_type: String = ""

signal card_selected(card_type: String, card_node: Node)

var is_selected := false

func _ready() -> void:
	# Set visible label if it exists
	if has_node("Label"):
		$Label.text = card_type

	# Connect press event
	self.pressed.connect(on_card_pressed)

func on_card_pressed():
	# Toggle Selection
	is_selected = !is_selected
	update_visual()
	emit_signal("card_selected", card_type, self)

func set_selected(state: bool):
	is_selected = state
	update_visual()

func update_visual():
	pass
