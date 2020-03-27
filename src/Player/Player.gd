extends KinematicBody2D


var is_moving = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var temp_flag = false
	if Input.is_key_pressed(KEY_W):
		var val = move_and_collide(Vector2(0, -1).normalized() * 700 * delta)
		if val == null:
			temp_flag = true
	if Input.is_key_pressed(KEY_S):
		var val = move_and_collide(Vector2(0, 1).normalized() * 700 * delta)
		if val == null:
			temp_flag = true
	if Input.is_key_pressed(KEY_A):
		var val = move_and_collide(Vector2(-1, 0).normalized() * 700 * delta)
		if val == null:
			temp_flag = true
	if Input.is_key_pressed(KEY_D):
		var val = move_and_collide(Vector2(1, 0).normalized() * 700 * delta)
		if val == null:
			temp_flag = true
	if temp_flag:
		is_moving = true
	else:
		is_moving = false
