extends StaticBody2D

var selected: bool = false

signal button_clicked(pos)

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("interact"):
		selected = true

func _ready():
	input_pickable = true

func _process(delta):
	if selected:
		position = get_global_mouse_position()
	
	if Input.is_action_just_released("interact"):
		selected = false

func _on_output_button_pressed():
	Globals.buttons_clicked += 1
	if not $Output/OutputButton.has_wire:
		Globals.wire_start_pos = $Output/OutputButton.global_position
		Globals.start_button = $Output/OutputButton

func _on_input_button_1_pressed():
	Globals.buttons_clicked += 1
	if not $Input/InputButton1.has_wire:
		Globals.wire_end_pos = $Input/InputButton1.global_position
		Globals.end_button = $Input/InputButton1


func _on_input_button_2_pressed():
	Globals.buttons_clicked += 1
	if not $Input/InputButton2.has_wire:
		Globals.wire_end_pos = $Input/InputButton2.global_position
		Globals.end_button = $Input/InputButton2
