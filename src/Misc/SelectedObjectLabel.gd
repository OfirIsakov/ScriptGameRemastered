extends Label


var object_name = "<value>"
onready var obstacles = [$"/root/Main/YSort/Havit/KinematicBody2D", $"/root/Main/YSort/Havit2/KinematicBody2D"]


# Called when the node enters the scene tree for the first time.
func _ready():
	rect_position = get_global_mouse_position() + Vector2(-530, -340) # Replace with function body.
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rect_position = get_global_mouse_position() + Vector2(-530, -340)
	var render = false
	for obstacle in obstacles:
		if obstacle != null and obstacle.hover == true:
			render = true
			object_name = str(obstacle.object_name)
			break
	visible = render
	text = object_name
