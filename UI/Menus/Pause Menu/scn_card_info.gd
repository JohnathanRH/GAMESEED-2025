extends TextureRect

@onready var pause_scene = self.get_parent() as CanvasLayer
var info_panel : InfoPanel

@export var info_title : String
@export var info_content : Array[String]

func _on_mouse_entered() -> void:
	info_panel = load("res://UI/Component/Panels/scn_text_panel.tscn").instantiate()
	info_panel.title = info_title
	info_panel.contents = info_content
	pause_scene.add_child(info_panel)


func _on_mouse_exited() -> void:
	info_panel.queue_free()
