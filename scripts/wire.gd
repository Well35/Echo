extends Line2D

var start_pos: Vector2
var end_pos: Vector2
var start_button: Button
var end_button: Button

@onready var rect: CollisionShape2D = $Area2D/CollisionShape2D
var shape = RectangleShape2D.new()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_point_position(0, start_button.global_position + start_button.size / 2)
	set_point_position(1, end_button.global_position + end_button.size / 2)
	
	shape.size.x = get_point_position(1).distance_to(get_point_position(0))
	shape.size.y = width
	$Area2D/CollisionShape2D.set_shape(shape)
	rect.rotation = (get_point_position(1) - get_point_position(0)).normalized().angle()
	rect.position = (get_point_position(0) + get_point_position(1)) / 2

# When user right-clicks on a wire, remove it and clear button properties
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("remove"):
		start_button.transfer_button = null
		start_button.has_wire = false
		end_button.has_wire = false
		queue_free()
		print("hello")
