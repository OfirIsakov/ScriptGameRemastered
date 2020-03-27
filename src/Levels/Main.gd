extends Node2D


var is_moving = false
var direction = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	is_moving = $YSort/Player.is_moving
	$SelectedObjectLabel/Label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_moving = $YSort/Player.is_moving
	var flag = false
	var name = "<value>"
	var obstacles = [$YSort/Obstacle1/KinematicBody2D]
	for obstacle in obstacles:
		if obstacle != null and obstacle.hover == true:
			flag = true
			name = str(obstacle.object_name)
			break
	$SelectedObjectLabel/Label.visible = flag
	$SelectedObjectLabel/Label.text = name
