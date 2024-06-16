extends CanvasLayer

var input_pin_scene = preload("res://scenes/input_pin.tscn")
var and_gate_scene = preload("res://scenes/and_gate.tscn")
var or_gate_scene = preload("res://scenes/or_gate.tscn")
var nor_gate_scene = preload("res://scenes/nor_gate.tscn")

signal eval

func _on_and_gate_button_pressed():
	create_gate(and_gate_scene)

func _on_input_node_button_pressed():
	var input_pin = input_pin_scene.instantiate()
	input_pin.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	get_parent().get_child(2).add_child(input_pin)
	Globals.input_pins += 1

func create_gate(gate_scene):
	var gate = gate_scene.instantiate()
	gate.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	get_parent().get_child(1).add_child(gate)

func _on_evaluate_button_pressed():
	eval.emit()


func _on_or_gate_button_pressed():
	create_gate(or_gate_scene)


func _on_nor_gate_button_pressed():
	create_gate(nor_gate_scene)
