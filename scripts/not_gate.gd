extends gate

func _ready():
	input_pickable = true
	is_not_gate = true

func evaluate():
	$Output/OutputButton.value = not input_button1.value
