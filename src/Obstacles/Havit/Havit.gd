extends KinematicBody2D


# Declare member variables here. Examples:
var hover = false
var object_name = "Havit"

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = position.y + 1000


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_mouse_entered():
	$Area2D/Sprite.material.set_shader_param("amount", "1.0")
	hover = true


func _on_Area2D_mouse_exited():
	$Area2D/Sprite.material.set_shader_param("amount", "0.0")
	hover = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_node("/root/Main/Player/PlayerAnimation").playComputerOpenAnim()
