extends PanelContainer

const SAVE_DIR = "user://"
const SAVE_EXT = ".tres"

@onready var slot_container = $CanvasLayer/VBoxContainer
@onready var playerVar = PlayerVariables.save_file as PlayerSaveFile
var slot_scene = preload("res://UI/Component/Save Slot/scn_save_slot.tscn")
var delete_scene = preload("res://UI/Component/Delete Save/scn_delete_save.tscn")

func _ready() -> void:
	
	for i in range(1, 4):
		var slot_path = SAVE_DIR + "slot_" + str(i) + SAVE_EXT
		#var slot_path = "res://Save Files/player_save_file.tres"
		var slot_instance = slot_scene.instantiate()
		var delete_instance = delete_scene.instantiate()
		
		if FileAccess.file_exists(slot_path):
			var save_data: PlayerSaveFile = ResourceLoader.load(slot_path)
			slot_instance.setup(save_data, slot_path)
			delete_instance.setup(slot_path)
		else:
			slot_instance.empty_setup(slot_path)
			delete_instance.empty_setup()
		
		slot_container.add_child(slot_instance)
		slot_container.add_child(delete_instance)

# save button funcitonality moved to the button scene itself
