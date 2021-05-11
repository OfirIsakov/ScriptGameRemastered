extends Node2D


var direction = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	$SelectedObjectLabel/Label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var is_visible = false
	var name = "<value>"
	var obstacles = [$Enviroment/Obstacle1/StaticBody2D]
	for obstacle in obstacles:
		if obstacle != null and obstacle.hover == true:
			is_visible = true
			name = str(obstacle.object_name)
			break
	$SelectedObjectLabel/Label.visible = is_visible
	$SelectedObjectLabel/Label.text = name
