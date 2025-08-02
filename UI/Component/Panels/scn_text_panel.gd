extends NinePatchRect
class_name InfoPanel

var title : String
var contents : Array[String]

func _ready() -> void:
	$VBoxContainer/title.text = title
	for content in contents:
		var newLabel = Label.new()
		newLabel.text = content
		$VBoxContainer.add_child(newLabel)
	
func _process(delta: float) -> void:
	position = get_global_mouse_position()
