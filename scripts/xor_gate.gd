extends gate

func evaluate():
	$Output/OutputButton.value = (input_button1.value != input_button2.value)
