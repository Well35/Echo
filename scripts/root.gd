extends Node2D

var wire_scene = preload("res://scenes/wire.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var gates = $Gates.get_children()
	var selected_count = 0
	gates.reverse()
	for gate in gates:
		if gate.selected:
			selected_count += 1
		if selected_count > 1 and gate.selected:
			gate.selected = false
	
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
			Globals.start_button.has_wire = true
			Globals.end_button.has_wire = true
			$Wires.add_child(wire)
		
		# Clear wire positions after creating wire to help with error checking
		Globals.wire_end_pos = Vector2.ZERO
		Globals.wire_start_pos = Vector2.ZERO
		Globals.buttons_clicked = 0


func evaluate():
	print("evaluate")
