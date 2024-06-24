extends StaticBody2D

var selected: bool = false
var evaluated: bool
var has_both_inputs: bool = false
@onready var output_button = $Button

@onready var input_button1 = $Button
@onready var input_button2 = $Button
@onready var input_number: int

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("interact"):
		selected = true
	elif event.is_action_pressed("remove"):
		delete()

func delete():
	if output_button.has_wire:
		output_button.transfer_button.previous_button = null
		output_button.transfer_button.has_wire = false
		output_button.transfer_button.wire.queue_free()
	Globals.input_pins -= 1
	queue_free()

func _ready():
	input_pickable = true
	#$Button.value = false #TODO: change from default value of true
	$Button.value_changed = true
	evaluated = true

func _process(delta):
	if selected:
		position = get_global_mouse_position()
	
	if Input.is_action_just_released("interact"):
		selected = false
	
	$Number.text = str(input_number)


func _on_button_pressed():
	Globals.buttons_clicked += 1
	if not $Button.has_wire:
		Globals.wire_start_pos = $Button.global_position
		Globals.start_button = $Button
