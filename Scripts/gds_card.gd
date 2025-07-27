extends TextureButton

@export var card_type: String = ""
@export var card_back_texture: Texture2D
@export var card_front_texture: Texture2D
@export var is_flipped_up = false

var card_symbol = {"attack":"res://Assets/Card/SymbolSword.png", 
					"fireball":"res://Assets/Card/SymbolFire.png", 
					"heal":"res://Assets/Card/SymbolHeal.png", 
					"shield":"res://Assets/Card/SymbolShield.png"}

signal card_selected(card_type: String, card_node: Node)


func _ready() -> void:
	self.pressed.connect(_on_button_pressed)
	self.texture_normal = card_back_texture
	$Sprite2D.texture = load(card_symbol[card_type])


func _on_button_pressed():
	emit_signal("card_selected", card_type, self)
	pass


func flip_up():
	if is_flipped_up: return
	
	is_flipped_up = true
	$Sprite2D.visible = true
	self.texture_normal = card_front_texture
	self.disabled = true


func flip_down():
	if !is_flipped_up: return
	
	is_flipped_up = false
	$Sprite2D.visible = false
	self.texture_normal = card_back_texture
	self.disabled = false



func set_as_matched():
	self.disabled = true
