extends Camera2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("LeftMouse"):
		global_position += event.relative
