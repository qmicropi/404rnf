extends Button

func _ready():
	pressed.connect(_on_start_connect)
	
func _on_start_connect():
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/control.tscn")
