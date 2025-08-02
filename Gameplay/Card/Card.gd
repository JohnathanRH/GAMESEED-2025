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
	$Sprite2D2.material = $Sprite2D2.material.duplicate()
	$Sprite2D2/Sprite2D.material = $Sprite2D2/Sprite2D.material.duplicate()
	
	self.pressed.connect(_on_button_pressed)
	$Sprite2D2/Sprite2D.texture = load(card_symbol[card_type])
	custom_minimum_size = Vector2(20,24) # Hard coded, this is the size of the card texture

func _on_button_pressed():
	if !is_flipped_up and !has_matched:
		#$AnimationPlayer.play("flip_up")
		emit_signal("card_selected", card_type, self)
		

func flip_up():
	if is_flipped_up: return
	AudioManager.play_flip()
	is_flipped_up = true
	disabled = true
	$HoverAnimPlayer.play("hover_exit")
	
	_set_card_front()
	$AnimationPlayer.play("flip_up")

func flip_down():
	if !is_flipped_up: return
	AudioManager.play_flip()
	is_flipped_up = false
	disabled = false
	$AnimationPlayer.play("flip_down")

func dissolving():
	$AnimationPlayer.play("dissolving")

func reset():
	$AnimationPlayer.play("RESET")

func condensing():
	$AnimationPlayer.play("condensing")

func _on_mouse_entered() -> void:
	if !is_flipped_up:
		$HoverAnimPlayer.play("hover_enter")


func _on_mouse_exited() -> void:
	if !is_flipped_up:
		$HoverAnimPlayer.play("hover_exit")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=="flip_down" and has_matched:
		dissolving()
	elif anim_name=="dissolving":
		self.disabled = true
		self.modulate.a = 0
		
func _set_card_front():
	var symbol_texture = load(card_symbol[card_type])

	if card_type == "heal":
		$Sprite2D2.visible = false
		$Sprite2D3.visible = true
		$Sprite2D3/Sprite2D.texture = symbol_texture
	else:
		$Sprite2D2.visible = true
		$Sprite2D3.visible = false
		$Sprite2D2/Sprite2D.texture = symbol_texture
