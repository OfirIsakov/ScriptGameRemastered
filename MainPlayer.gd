extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = position.y + 1000

func _process(delta):
	z_index = position.y + 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_key_pressed(KEY_W):
		move_and_collide(Vector2(0, -1).normalized() * 700 * delta)
	if Input.is_key_pressed(KEY_S):
		move_and_collide(Vector2(0, 1).normalized() * 700 * delta)
	if Input.is_key_pressed(KEY_A):
		move_and_collide(Vector2(-1, 0).normalized() * 700 * delta)
	if Input.is_key_pressed(KEY_D):
		move_and_collide(Vector2(1, 0).normalized() * 700 * delta)
