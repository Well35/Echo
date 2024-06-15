extends StaticBody2D

var selected: bool = false

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


func _on_button_pressed():
	Globals.buttons_clicked += 1
	if not $Button.has_wire:
		Globals.wire_start_pos = $Button.global_position
		Globals.start_button = $Button
