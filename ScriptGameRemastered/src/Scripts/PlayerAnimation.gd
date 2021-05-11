extends AnimatedSprite


var is_running = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_A) and not is_running and not Input.is_key_pressed(KEY_D):
		play("running")
		flip_h = true
	elif Input.is_key_pressed(KEY_D) and not is_running and not Input.is_key_pressed(KEY_A):
		play("running")
		flip_h = false
	elif Input.is_key_pressed(KEY_W) and not is_running:
		play("running")
		#flip_h = false
	elif Input.is_key_pressed(KEY_S) and not is_running:
		play("running")
		#flip_h = false
	elif not (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_D)):
		play("idle")
