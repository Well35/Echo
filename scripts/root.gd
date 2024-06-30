extends Node2D

var wire_scene: PackedScene = preload("res://scenes/wire.tscn")
var popup_scene: PackedScene = preload("res://scenes/truth_table_popup.tscn")
var truth_table_tile_scene: PackedScene = preload("res://scenes/truth_table_tile.tscn")
var error_scene: PackedScene = preload("res://scenes/error_popup.tscn")

var truth_table_popup: PanelContainer
@onready var gates = $Gates.get_children()
@onready var inputs = $Inputs.get_children()
@onready var wires = $Wires.get_children()

func _ready():
	DisplayServer.window_set_min_size(Vector2i(1260, 720))

func _process(delta):
	set_gates_inputs_and_wires()
	var selected_count = 0
	var selectable_objects = gates + inputs + wires
	selectable_objects.append($OutputPin)
	
	for obj in selectable_objects:
		if obj.selected:
			selected_count += 1
		if selected_count > 1 and obj.selected:
			obj.selected = false
	
	if Globals.buttons_clicked > 1:
		if Globals.wire_end_pos != Vector2.ZERO and Globals.wire_start_pos != Vector2.ZERO:
			add_wire()
		
		# Clear wire positions after creating wire to help with error checking
		Globals.wire_end_pos = Vector2.ZERO
		Globals.wire_start_pos = Vector2.ZERO
		Globals.buttons_clicked = 0

func generate_error(s: String):
	var error = error_scene.instantiate()
	error.error_text = s
	$UI.add_child(error)

func create_table_outline():
	truth_table_popup = popup_scene.instantiate()
	truth_table_popup.columns = inputs.size() + 1
	$UI.add_child(truth_table_popup)
	draw_top_row_of_table(inputs.size())

func transfer_values():
	# Transfer all values of input nodes into gates
	for input in inputs:
		input.output_button.transfer_button.value = input.output_button.value
		input.output_button.transfer_button.value_changed = true
			
	# Transfer all values of evaluated gates
	for gate in gates:
		if gate.evaluated:
			gate.output_button.transfer_button.value = gate.output_button.value
			gate.output_button.transfer_button.value_changed = true

func evaluate_gates():
	for gate in gates:
		if gate.is_not_gate and gate.input_button1.value_changed and not gate.evaluated:
			gate.evaluate()
			gate.evaluated = true
		elif not gate.is_not_gate and gate.input_button1.value_changed and gate.input_button2.value_changed and not gate.evaluated:
			gate.evaluate()
			gate.evaluated = true

# The heart of the program
func evaluate():
	var x: int = pow(2, inputs.size())
	
	if gates.size() == 0 or inputs.size() == 0:
		generate_error("Place at least one input pin and one logic gate.")
		return
	
	if not $OutputPin.output_button.has_wire:
		generate_error("The output pin must have a wire connected to it.")
		return
	
	if check_wires() == false:
		generate_error("Missing wire connections in input pins or logic gates. Can't evaluate.")
		return
	
	#clear_gates()
	create_table_outline()
	
	for i in range(x, 0, -1):
		# Reset all gates before running through current iteration
		clear_gates()
		
		# Get every permutation of the input pins being on/off
		for j in range(inputs.size()):
			var num = ((i >> j) & 1)
			var tile = instantiate_tile(Color("GRAY"), str(num))
			truth_table_popup.tiles.add_child(tile)
			inputs[j].output_button.value = bool(num)
			
		while not $OutputPin.output_button.value_changed:
			transfer_values()
			evaluate_gates()
			
		var tile = instantiate_tile(Color("GRAY"), str(int($OutputPin.output_button.value)))
		truth_table_popup.tiles.add_child(tile)

func check_wires():
	for gate in gates:
		if not gate.is_not_gate:
			if not gate.input_button2.has_wire:
				return false
		else:
			if not gate.input_button1.has_wire or not gate.output_button.has_wire:
				return false
	
	for input in inputs:
		if not input.output_button.has_wire:
			return false

func clear_gates():
	for gate in gates:
		gate.evaluated = false
		gate.input_button1.value_changed = false
		if not gate.is_not_gate:
			gate.input_button2.value_changed = false
		$OutputPin.output_button.value_changed = false

func draw_top_row_of_table(row_length: int):
	for i in range(row_length):
		var tile = instantiate_tile("GRAY", str(i))
		truth_table_popup.tiles.add_child(tile)
	
	var tile = instantiate_tile("GRAY", "Output")
	truth_table_popup.tiles.add_child(tile)

func instantiate_tile(tile_color: Color, tile_text: String):
	var tile = truth_table_tile_scene.instantiate()
	tile.rect_color = tile_color
	tile.text = tile_text
	return tile

func _on_ui_clear():
	var objects_to_delete = gates + inputs + wires
	for obj in objects_to_delete:
		obj.queue_free()
	Globals.input_pins = 0
	$OutputPin.output_button.has_wire = false

func set_gates_inputs_and_wires():
	gates = $Gates.get_children()
	inputs = $Inputs.get_children()
	wires = $Wires.get_children()
	gates.reverse()
	inputs.reverse()

func add_wire():
	var wire = wire_scene.instantiate()
	wire.add_point(Globals.wire_start_pos)
	wire.add_point(Globals.wire_end_pos)
	wire.start_button = Globals.start_button
	wire.end_button = Globals.end_button
	
	# Point the output to the correct input on another gate
	Globals.start_button.transfer_button = Globals.end_button
	Globals.end_button.previous_button = Globals.start_button
	Globals.start_button.has_wire = true
	Globals.end_button.has_wire = true
	Globals.start_button.wire = wire
	Globals.end_button.wire = wire
	$Wires.add_child(wire)
