extends Line2D

var start_button: Button
var end_button: Button

@onready var rect: CollisionShape2D = $Area2D/CollisionShape2D
var shape = RectangleShape2D.new()

func _process(delta):
	var start_position: Vector2 = start_button.global_position + start_button.size / 2
	var end_position: Vector2 = end_button.global_position + end_button.size / 2
	
	set_point_position(0, start_position)
	set_point_position(1, end_position)
	
	shape.size.x = get_point_position(1).distance_to(get_point_position(0))
	shape.size.y = width
	$Area2D/CollisionShape2D.set_shape(shape)
	rect.rotation = (get_point_position(1) - get_point_position(0)).normalized().angle()
	rect.position = (get_point_position(0) + get_point_position(1)) / 2


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("remove"):
		start_button.transfer_button = null
		start_button.has_wire = false
		end_button.has_wire = false
		queue_free()
