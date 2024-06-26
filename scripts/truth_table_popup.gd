extends PanelContainer

@onready var tiles = $VBoxContainer/MarginContainer/MarginContainer/ScrollContainer/TableTiles
@onready var columns = 2

func _process(delta):
	$VBoxContainer/MarginContainer/MarginContainer/ScrollContainer/TableTiles.columns = columns

func _on_exit_button_pressed():
	queue_free()
