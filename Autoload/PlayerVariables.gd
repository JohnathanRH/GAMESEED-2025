extends Node

var save_file : PlayerSaveFile
var save_path := ""   

func _ready() -> void:
	save_file = load_data()

func load_data() -> PlayerSaveFile:
	# if there's a save file (.tres) then load it into the save_file var
	if(ResourceLoader.exists(save_path)):
		print("Save found")
		return ResourceLoader.load(save_path).duplicate(true)
	
	# Else create a new save file. with the default values (defaults are hard coded for now)
	else:
		var new_save = PlayerSaveFile.new() as PlayerSaveFile
		new_save.hp = 10
		new_save.name = ""
		new_save.level = 0
		new_save.stage = "1"
		print("Save NOT found")
		return new_save

func save_data() -> void:
	# Since this script is autoloaded, this save function can be fired from anywhere!
	ResourceSaver.save(save_file, save_path)

func reset_data() -> void:
	save_file = load_data()

func set_save_path(new_save_path: String):
	save_path = new_save_path
	save_file = load_data()
