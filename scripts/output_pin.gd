extends StaticBody2D

@onready var output_button = $Button

func _on_button_pressed():
	Globals.buttons_clicked += 1
	if not $Button.has_wire:
		Globals.wire_end_pos = $Button.global_position
		Globals.end_button = $Button
