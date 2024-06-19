extends PanelContainer

@onready var tiles = $VBoxContainer/MarginContainer/TableTiles
@onready var columns

func _process(delta):
	$VBoxContainer/MarginContainer/TableTiles.columns = columns

func _on_exit_button_pressed():
	queue_free()
