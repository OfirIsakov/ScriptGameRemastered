extends Area2D


var direction = Vector2()
var collided = false

# Called when the node enters the scene tree for the first time.
func _ready():
	direction.x = 1
	direction.y = 1
	direction = direction.normalized()
	position = get_viewport_rect().size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_W):
		position.y -= 700 * delta
		if collided:
			position.y += 700 * delta
	if Input.is_key_pressed(KEY_S):
		position.y += 700 * delta
		if collided:
			position.y -= 700 * delta
	if Input.is_key_pressed(KEY_A):
		position.x -= 700 * delta
		if collided:
			position.x += 700 * delta
	if Input.is_key_pressed(KEY_D):
		position.x += 700 * delta
		if collided:
			position.x -= 700 * delta
		


func _on_Player_body_entered(body):
	collided = true


func _on_Player_body_exited(body):
	collided = false
