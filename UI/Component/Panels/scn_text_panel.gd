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
	# Check if viewport is beyond the viewport y axis.
	var viewport_y = get_viewport().get_visible_rect().size.y
	if (get_global_mouse_position().y + size.y > viewport_y):
		
		# if is beyond the y axis, position the panel so it doesnt go out the viewport
		position.x = get_global_mouse_position().x
		position.y = get_global_mouse_position().y - size.y
	else:
		
		# Just position it on the mouse
		position = get_global_mouse_position()
