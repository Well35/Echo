extends ColorRect

var text: String
var rect_color: Color

func _process(delta):
	$CenterContainer/Label.text = text
	color = rect_color
