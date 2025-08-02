extends Sprite2D

func play_attack():
	$AnimationPlayer.play("Attack")
	
func play_heal():
	$AnimationPlayer.play("Heal")

func play_ignite():
	$AnimationPlayer.play("Ignite")
	
func play_slime_ability():
	$AnimationPlayer.play("Slime Ability")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	self.visible = false


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	self.visible = true
