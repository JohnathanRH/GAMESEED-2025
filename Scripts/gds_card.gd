extends Button

@export var card_type: String = ""
@export var is_flipped_up = false
var has_matched := false
var is_sticky := false

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
	if (!GlobalVariables.is_checking_match):
		$AnimationPlayer.play("flip_up")
		emit_signal("card_selected", card_type, self)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass

func flip_up():
	if is_flipped_up: return
	$card_flip_audio.play()
	is_flipped_up = true
	self.disabled = true
	$HoverAnimPlayer.play("hover_exit")
	$AnimationPlayer.play("flip_up")
	#print("flip up")

func flip_down():
	if !is_flipped_up: return
	$card_flip_audio.play()
	is_flipped_up = false
	if is_sticky:
		self.disabled = true
	else:
		self.disabled = false
	$AnimationPlayer.play("flip_down")
	#print("flip down")
	
	
func set_as_matched():
	self.disabled = true


func _on_mouse_entered() -> void:
	if !is_flipped_up:
		$HoverAnimPlayer.play("hover_enter")


func _on_mouse_exited() -> void:
	if !is_flipped_up:
		$HoverAnimPlayer.play("hover_exit")
