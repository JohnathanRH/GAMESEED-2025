extends PanelContainer

const SAVE_DIR = "res://Save Files/"
const SAVE_EXT = ".tres"

@onready var slot_container = $CanvasLayer/VBoxContainer
@onready var playerVar = PlayerVariables.save_file as PlayerSaveFile
var slot_scene = preload("res://Scenes/UI/scn_save_slot.tscn")
var stage_path = ""

func _ready() -> void:
	
	for i in range(1, 4):
		var slot_path = SAVE_DIR + "slot_" + str(i) + SAVE_EXT
		#var slot_path = "res://Save Files/player_save_file.tres"
		var slot_instance = slot_scene.instantiate()
		
		slot_instance.pressed.connect(_on_save_button_pressed.bind(i))
		
		if FileAccess.file_exists(slot_path):
			var save_data: PlayerSaveFile = ResourceLoader.load(slot_path)
			stage_path = save_data.stage
			slot_instance.setup(save_data, slot_path)
		else:
			slot_instance.empty_setup(slot_path)
		slot_container.add_child(slot_instance)
	
	pass

func _on_save_button_pressed(slot_number: int):
	print("Button on save slot " + str(slot_number) + "pressed")
	
	var slot = slot_container.get_child(slot_number-1)
	PlayerVariables.set_save_path(slot.save_path)
	
	if slot.is_empty:
		get_tree().change_scene_to_file("res://Scenes/UI/scn_input_empty_save_slot.tscn")
		
	else:
		get_tree().change_scene_to_file(playerVar.stage)
