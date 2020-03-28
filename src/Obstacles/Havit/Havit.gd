extends Obstacle


func _ready() -> void:
	object_name = "Havit"
	connect("input_event", get_parent(), "_on_Area2D_input_event")
