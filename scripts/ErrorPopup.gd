extends PanelContainer

@onready var error_text

func _process(delta):
	$VBoxContainer/MarginContainer/ErrorText.text = error_text

func _on_ok_button_pressed():
	queue_free()

func _on_exit_button_pressed():
	queue_free()
