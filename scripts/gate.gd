class_name gate extends StaticBody2D

# The inherited script all logic gates will use
# TODO: fix the requirement for each gate to have specific button paths in their scenes
#	this will cause problems with gates like the NOT gate
#
# Each logic gate script must contain an evaluate() function that changes the output buttons value
#	to whatever the gate must do both inputs

var selected: bool = false
var evaluated: bool = false
var has_both_inputs: bool = false
var is_not_gate: bool = false
@onready var output_button = $Output/OutputButton
@onready var input_button1 = $Input/InputButton1
var input_button2

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("interact"):
		selected = true

func _ready():
	if not is_not_gate:
		input_button2 = $Input/InputButton2
	input_pickable = true

func _process(delta):
	if selected:
		position = get_global_mouse_position()
	if Input.is_action_just_released("interact"):
		selected = false

func button_pressed(b: Button, is_input_button: bool):
	Globals.buttons_clicked += 1
	if not b.has_wire and not is_input_button:
		Globals.wire_start_pos = b.global_position + b.size / 2
		Globals.start_button = b
	if not b.has_wire and is_input_button:
		Globals.wire_end_pos = b.global_position + b.size / 2
		Globals.end_button = b

func _on_output_button_pressed():
	button_pressed(output_button, false)

func _on_input_button_1_pressed():
	button_pressed(input_button1, true)

func _on_input_button_2_pressed():
	button_pressed(input_button2, true)

#func evaluate():
#	$Output/OutputButton.value = (input_button1.value and input_button2.value)
