extends Camera2D

var zoom_multiplayer = 1
var camera_speed = 1
var zoom_end = 1 


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("LeftMouse"):
		global_position += -(event.relative) * camera_speed
	
	if Input.is_action_pressed("MouseWheelDown"):
		zoom += Vector2(0.01,0.01) * zoom_multiplayer
	if Input.is_action_pressed("MouseWheelUp"):
		if zoom < zoom_end:
			zoom -= Vector2(0.01,0.01) * zoom_multiplayer
