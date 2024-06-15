extends Line2D

var start_pos: Vector2
var end_pos: Vector2
var start_button: Button
var end_button: Button


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_point_position(0, start_button.global_position)
	set_point_position(1, end_button.global_position)
	pass
