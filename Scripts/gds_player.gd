extends Sprite2D
@onready var anim_player = $AnimationPlayer
@onready var player_save = PlayerVariables.save_file as PlayerSaveFile
@onready var hp_bar = $"../../CanvasLayer/scn_player_hp/TextureProgressBar"

func _input(event: InputEvent) -> void:
	# Save, for debugging only
	if(event.is_action_pressed("save")):
		PlayerVariables.save_data()

func _ready() -> void:
	PlayerVariables.save_file.hpSet.connect(_player_hurt)
	
	hp_bar.max_value = player_save.hp
	hp_bar.value = player_save.hp

	player_save.hpSet.connect(update_hp_bar)

func update_hp_bar():
	hp_bar.value = player_save.hp

func _on_hp_changed() -> void:
	hp_bar.value = player_save.hp

func _player_hurt():
	anim_player.play("hurt")
