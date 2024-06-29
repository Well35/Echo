extends CanvasLayer

var input_pin_scene = preload("res://scenes/input_pin.tscn")
var and_gate_scene = preload("res://scenes/and_gate.tscn")
var nand_gate_scene = preload("res://scenes/nand_gate.tscn")
var or_gate_scene = preload("res://scenes/or_gate.tscn")
var nor_gate_scene = preload("res://scenes/nor_gate.tscn")
var xor_gate_scene = preload("res://scenes/xor_gate.tscn")
var xnor_gate_scene = preload("res://scenes/xnor_gate.tscn")
var not_gate_scene = preload("res://scenes/not_gate.tscn")


signal eval
signal clear

func _on_and_gate_button_pressed():
	create_gate(and_gate_scene)

func _on_input_node_button_pressed():
	var input_pin = input_pin_scene.instantiate()
	input_pin.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	input_pin.input_number = Globals.input_pins
	get_parent().get_child(3).add_child(input_pin)
	Globals.input_pins += 1

func create_gate(gate_scene):
	var gate = gate_scene.instantiate()
	gate.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2)
	get_parent().get_child(2).add_child(gate)

func _on_evaluate_button_pressed():
	eval.emit()


func _on_or_gate_button_pressed():
	create_gate(or_gate_scene)

func _on_nor_gate_button_pressed():
	create_gate(nor_gate_scene)


func _on_nand_gate_button_pressed():
	create_gate(nand_gate_scene)


func _on_xor_gate_button_pressed():
	create_gate(xor_gate_scene)


func _on_xnor_gate_button_pressed():
	create_gate(xnor_gate_scene)


func _on_not_gate_button_pressed():
	create_gate(not_gate_scene)


func _on_clear_button_pressed():
	clear.emit()
