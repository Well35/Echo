extends CanvasLayer

var input_pin_scene = preload("res://scenes/input_pin.tscn")
var and_gate_scene = preload("res://scenes/and_gate.tscn")
#var or_gate_scene = preload("res://scenes/or_gate.tscn")

signal eval

func _on_and_gate_button_pressed():
	var and_gate = and_gate_scene.instantiate()
	and_gate.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	get_parent().get_child(1).add_child(and_gate)


func _on_input_node_button_pressed():
	var input_pin = input_pin_scene.instantiate()
	input_pin.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	get_parent().get_child(2).add_child(input_pin)
	Globals.input_pins += 1


func _on_evaluate_button_pressed():
	eval.emit()
