extends KinematicBody2D


# Declare member variables here. Examples:
var hover = false
var object_name = "Havit"
var hsv_h = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hsv_h += 1 * delta
	if hsv_h >= 360:
		hsv_h = 1
	$Area2D/Sprite.material.set_shader_param("outline_color", Color().from_hsv(float(hsv_h), 0.49, 0.92))

func _on_Area2D_mouse_entered():
	$Area2D/Sprite.material.set_shader_param("outline_width", "30")
	hover = true


func _on_Area2D_mouse_exited():
	$Area2D/Sprite.material.set_shader_param("outline_width", "0")
	hover = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_node("/root/Main/YSort/Player/PlayerAnimation").playComputerOpenAnim()
