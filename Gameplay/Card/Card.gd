extends Button

@export var card_type: String = ""
@export var is_flipped_up = false
var has_matched = false
enum State { IDLE, AWAITING_SECOND_CARD, CHECKING }
var card_symbol = {"attack":"res://Assets/Card/SymbolSword.png", 
					"fireball":"res://Assets/Card/SymbolFire.png", 
					"heal":"res://Assets/Card/SymbolHeal.png", 
					"shield":"res://Assets/Card/SymbolShield.png"}

signal card_selected(card_type: String, card_node: Node)

func _ready() -> void:
	self.pressed.connect(_on_button_pressed)
	$Sprite2D2/Sprite2D.texture = load(card_symbol[card_type])
	custom_minimum_size = Vector2(20,24) # Hard coded, this is the size of the card texture

func _on_button_pressed():
	if !is_flipped_up:
		#$AnimationPlayer.play("flip_up")
		emit_signal("card_selected", card_type, self)
		

func flip_up():
	if is_flipped_up: return
	AudioManager.play_flip()
	is_flipped_up = true
	self.disabled = true
	$HoverAnimPlayer.play("hover_exit")
	$AnimationPlayer.play("flip_up")

func flip_down():
	if !is_flipped_up: return
	AudioManager.play_flip()
	is_flipped_up = false
	self.disabled = false
	$AnimationPlayer.play("flip_down")


func _on_mouse_entered() -> void:
	if !is_flipped_up:
		$HoverAnimPlayer.play("hover_enter")


func _on_mouse_exited() -> void:
	if !is_flipped_up:
		$HoverAnimPlayer.play("hover_exit")
