extends PanelContainer

@onready var tiles = $VBoxContainer/MarginContainer/MarginContainer/TableTiles
@onready var columns = 2

func _process(delta):
	$VBoxContainer/MarginContainer/MarginContainer/TableTiles.columns = columns

func _on_exit_button_pressed():
	queue_free()
