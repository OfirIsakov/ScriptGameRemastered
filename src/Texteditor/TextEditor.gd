extends Node2D


var keywords = ["var", "set", "to"]
var textedit_text = [
	"var size = $INPUT",
	"set object.size to size",
	"lol this is an input: $INPUT but it is bad"
]
var default_values = [10, 333] # will show in orther, first value with first "$INPUT"

export var editor_size = Vector2(500, 500)

var allowed_chars = [
	# alphabet
	KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F, KEY_G, KEY_H, KEY_I, KEY_J, KEY_K, KEY_L, KEY_M, KEY_N, KEY_O, KEY_P,
	KEY_Q, KEY_R, KEY_S, KEY_T, KEY_U, KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z,
	
	# numbers + keypad numbers
	KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9,
	KEY_KP_0, KEY_KP_1, KEY_KP_2, KEY_KP_3, KEY_KP_4, KEY_KP_5, KEY_KP_6, KEY_KP_7, KEY_KP_8, KEY_KP_9,
	
	# misc
	KEY_KP_MULTIPLY, KEY_KP_DIVIDE, KEY_KP_SUBTRACT, KEY_KP_PERIOD, KEY_KP_ADD,
	KEY_ASTERISK, KEY_SLASH, KEY_MINUS, KEY_PLUS,
	KEY_SPACE, KEY_BACKSPACE, KEY_DELETE, KEY_ESCAPE
]

# no touch
var in_editor = false
var editable_locations = [] # contains lists [line_number, column_number, editable_length]

onready var player_node = $"/root/Main/YSort/Player"
onready var camera_node = $"/root/Main/YSort/Player/Camera2D"
onready var exit_button = $"/root/Main/TextEditor/CanvasLayer/ExitButton"
onready var textedit_node = $"/root/Main/TextEditor/CanvasLayer/TextEdit"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textedit_node.visible = false
	exit_button.visible = false
	textedit_node.wrap_enabled = true
	textedit_node.show_line_numbers = true
	textedit_node.shortcut_keys_enabled = true

	# syntax highlighting
	textedit_node.set_syntax_coloring(true)
	for keyword in keywords:
		textedit_node.add_keyword_color(keyword, Color.red)
	
	# change all the ""$INPUT" into the default values and remember
	var input_line_number = 0
	for line_num in range(len(textedit_text)):
		while "$INPUT" in textedit_text[line_num]:
			editable_locations.append([line_num, textedit_text[line_num].find("$INPUT"), str(default_values[input_line_number]).length()])
			textedit_text[line_num] = textedit_text[line_num].replace("$INPUT", str(default_values[input_line_number]))

		if "$INPUT" in textedit_text[line_num]:
			input_line_number += 1

	textedit_node.text = PoolStringArray(textedit_text).join("\n")


func _process(delta: float) -> void:
	if textedit_node.is_selection_active():
		textedit_node.deselect()

	if not vlidate_cursor_location():
		var closest_input = find_closest_input()
		textedit_node.cursor_set_line(closest_input[0], true, false)
		textedit_node.cursor_set_column(closest_input[1], true)
		textedit_node.get_tree().set_input_as_handled() # get rid of this comment


# Called every frame a key is pressed.
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if Input.is_key_pressed(KEY_ENTER) or Input.is_key_pressed(KEY_SPACE):
			get_tree().set_input_as_handled()

		# check is the eventt is a keypress, input events can also be mouse move
		if in_editor:
			# check if user want to exit
			if Input.is_key_pressed(KEY_ESCAPE):
				_on_ExitButton_pressed()

			if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_RIGHT):
				return
			
			var line_num = textedit_node.cursor_get_line()
			var column_num = textedit_node.cursor_get_column()
			
			# loop over valid spots
			print(editable_locations)
			for place in editable_locations: # each place contains lists [line_number, column_number, editable_length]
				if validate_input(event) and line_num == place[0] and column_num >= place[1] and column_num <= place[1] + place[2]:
					if Input.is_key_pressed(KEY_BACKSPACE) or Input.is_key_pressed(KEY_DELETE):
						if place[2] > 0:
							place[2] -= 1
							return
					else:
						place[2] += 1
						return
			get_tree().set_input_as_handled()
		else:
			if Input.is_key_pressed(KEY_SPACE):
				in_editor = true
				camera_node.position = Vector2(-editor_size[0] / 2 , 0.0) + camera_node.position
				textedit_node.cursor_set_line(editable_locations[0][0], true, false)
				textedit_node.cursor_set_column(editable_locations[0][1] + editable_locations[0][2], true)
				textedit_node.visible = true
				exit_button.visible = true
				player_node.set_physics_process(false)
				resize(editor_size[0], editor_size[1])
				exit_button._set_position(Vector2(editor_size[0] - exit_button.get_size()[0], get_position()[1]))
				textedit_node.grab_focus()
				textedit_node.readonly = false


# Resizes
func resize(size_x: int, size_y: int) -> void:
	#TODO make the scaling smooth
	#TODO make the scaling smooth
	#TODO make the scaling smooth
	#TODO make the scaling smooth
	#TODO make the scaling smooth
	#TODO make the scaling smooth
	#TODO make the scaling smooth
	textedit_node._set_size(Vector2(size_x, size_y))


# only checks if char is valid not validates it... Amit Katz!
func validate_input(event: InputEventKey) -> bool:
	if event.scancode in allowed_chars:
		return true
	return false


# only checks if char is valid not validates it... Amit Katz!
func vlidate_cursor_location() -> bool:
	for place in editable_locations:
		if textedit_node.cursor_get_line() == place[0] and \
				textedit_node.cursor_get_column() <= place[2] + place[1] and \
				textedit_node.cursor_get_column() >= place[1]:
			return true
	return false


# funciton finds the closes input to the cursor location.
# returns [line_number, column_number]
# returns [0, 0] if no inputs found
func find_closest_input() -> Array:
	if len(editable_locations) != 0:
		for place in editable_locations:
			if textedit_node.cursor_get_line() == place[0]:
				if textedit_node.cursor_get_column() <= place[1]:
					return [place[0], place[1]]
				else:
					return [place[0], place[1] + place[2]]
		return [editable_locations[0][0], editable_locations[0][1]]
	return [0, 0]


func _on_ExitButton_pressed() -> void:
	resize(0.0, 0.0)
	if in_editor: # disable the textedit 
		in_editor = false
		camera_node.position = Vector2(editor_size[0] / 2 , 0.0) + camera_node.position
		textedit_node.visible = false
		exit_button.visible = false
		textedit_node.readonly = true
		player_node.set_physics_process (true)
