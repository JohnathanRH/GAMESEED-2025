extends TextureButton

@export var card_type = ""

func _ready() -> void:
	$Label.text = card_type
