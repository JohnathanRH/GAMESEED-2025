extends Button

@export var card_type: String = ""
@export var is_flipped_up = false

var card_symbol = {"attack":"res://Assets/Card/SymbolSword.png", 
					"fireball":"res://Assets/Card/SymbolFire.png", 
					"heal":"res://Assets/Card/SymbolHeal.png", 
					"shield":"res://Assets/Card/SymbolShield.png"}

signal card_selected(card_type: String, card_node: Node)

func _ready() -> void:
	GlobalVariables.cardAnimSpeedSet.connect(update_anim_speed)
	self.pressed.connect(_on_button_pressed)
	$Sprite2D2/Sprite2D.texture = load(card_symbol[card_type])
	custom_minimum_size = Vector2(20,24) # Hard coded, this is the size of the card texture
	$AnimationPlayer.speed_scale = GlobalVariables.card_anim_speed

func _on_button_pressed():
	$AnimationPlayer.play("flip_up")
	emit_signal("card_selected", card_type, self)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass

func flip_up():
	if is_flipped_up: return
	
	is_flipped_up = true
	self.disabled = true
	$AnimationPlayer.play("flip_up")


func flip_down():
	if !is_flipped_up: return
	
	is_flipped_up = false
	self.disabled = false
	$AnimationPlayer.play("flip_down")


func set_as_matched():
	self.disabled = true

func update_anim_speed() -> void:
	$AnimationPlayer.speed_scale = GlobalVariables.card_anim_speed
