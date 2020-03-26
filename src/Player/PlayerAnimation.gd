extends AnimatedSprite


var is_running = false
#var is_opening_computer = false
var is_hacking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_H):
		play("ComputerClose")
	if Input.is_key_pressed(KEY_A) and not is_running and not Input.is_key_pressed(KEY_D):
			flip_h = true
	elif Input.is_key_pressed(KEY_D) and not is_running and not Input.is_key_pressed(KEY_A):
			flip_h = false
	if not is_hacking:
		if Input.is_key_pressed(KEY_A) and not is_running and not Input.is_key_pressed(KEY_D):
			play("running")
		elif Input.is_key_pressed(KEY_D) and not is_running and not Input.is_key_pressed(KEY_A):
			play("running")
		elif Input.is_key_pressed(KEY_W) and not is_running:
			play("running")
			#flip_h = false
		elif Input.is_key_pressed(KEY_S) and not is_running:
			play("running")
			#flip_h = false
		elif not (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_D)):
			play("StandingHopHop")


func playComputerOpenAnim():
	is_hacking = true
	#is_opening_computer = true
	#connect("finished", self, "playComputerStandAnim")
	play("ComputerOpen");
	
func playComputerCloseAnim():
	play("ComputerOpen", true)

func finishComputerClosing():
	is_hacking = false

func playComputerStandAnim():
	#is_opening_computer = false
	if(animation == "ComputerOpen"):
		play("ComputerStanding")


func _on_PlayerAnimation_animation_finished():
	if(animation == "ComputerOpen"):
		play("ComputerStanding")
	elif(animation == "ComputerClose"):
		is_hacking = false
