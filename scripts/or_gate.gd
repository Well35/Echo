extends gate

func evaluate():
	$Output/OutputButton.value = (input_button1.value or input_button2.value)
