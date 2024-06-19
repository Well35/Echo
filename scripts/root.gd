extends Node2D

var wire_scene = preload("res://scenes/wire.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var gates = $Gates.get_children()
	var inputs = $Inputs.get_children()
	var selected_count = 0
	gates.reverse()
	for gate in gates:
		if gate.selected:
			selected_count += 1
		if selected_count > 1 and gate.selected:
			gate.selected = false
	
	for input in inputs:
		if input.selected:
			selected_count += 1
		if selected_count > 1 and input.selected:
			input.selected = false
	
	if Globals.buttons_clicked > 1:
		if Globals.wire_end_pos == Vector2.ZERO or Globals.wire_start_pos ==  Vector2.ZERO:
			pass
		else:
			#print(Globals.buttons_clicked)
			var wire = wire_scene.instantiate()
			wire.add_point(Globals.wire_start_pos)
			wire.add_point(Globals.wire_end_pos)
			wire.start_button = Globals.start_button
			wire.end_button = Globals.end_button
			
			# Point the output to the correct input on another gate
			Globals.start_button.transfer_button = Globals.end_button
			Globals.start_button.has_wire = true
			Globals.end_button.has_wire = true
			$Wires.add_child(wire)
		
		# Clear wire positions after creating wire to help with error checking
		Globals.wire_end_pos = Vector2.ZERO
		Globals.wire_start_pos = Vector2.ZERO
		Globals.buttons_clicked = 0


# The heart of the program
func evaluate():
	#print("evaluate")
	var gates = $Gates.get_children()
	var inputs = $Inputs.get_children()
	var x: int = pow(2, inputs.size())
	#gates.reverse()
	
	clear_gates()
	
	if check_wires() == false:
		print("Wires missing. Can't evaluate")
		return
	
	for i in range(x, 0, -1):
		var s: String
		# Reset all gates before running through current iteration
		clear_gates()
		
		# Get every permutation of the input pins being on/off
		for j in range(inputs.size()):
			var num = ((i >> j) & 1)
			s += str((i >> j) & 1)
			inputs[j].output_button.value = bool(num)
			#print(inputs[j].output_button.value)
			
		while not $OutputPin.output_button.value_changed:
			# Transfer all values of input nodes into gates
			for input in inputs:
				input.output_button.transfer_button.value = input.output_button.value
				input.output_button.transfer_button.value_changed = true
			
			# Transfer all values of evaluated gates
			for gate in gates:
				#print(gate)
				if gate.evaluated:
					# Set the value of the gate that was wired to the one just evaluated
					gate.output_button.transfer_button.value = gate.output_button.value
					gate.output_button.transfer_button.value_changed = true
			
			# Evaluate all gates with both inputs set
			for gate in gates:
				if gate.is_not_gate and gate.input_button1.value_changed and not gate.evaluated:
					gate.evaluate()
					gate.evaluated = true
				elif not gate.is_not_gate and gate.input_button1.value_changed and gate.input_button2.value_changed and not gate.evaluated:
					gate.evaluate()
					gate.evaluated = true
		s += " " + str($OutputPin.output_button.value)
		print(s)
	#print($OutputPin.output_button.value)
	

func check_wires():
	var gates = $Gates.get_children()
	var inputs = $Inputs.get_children()
	
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
	var gates = $Gates.get_children()
	for gate in gates:
			gate.evaluated = false
			gate.input_button1.value_changed = false
			if not gate.is_not_gate:
				gate.input_button2.value_changed = false
			$OutputPin.output_button.value_changed = false
