extends Camera2D

var zoom_multiplayer = 3
var camera_speed = 1
var zoom_end = 1 


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("RightMouse"):
		global_position += -(event.relative) * camera_speed
	
	if Input.is_action_pressed("MouseWheelDown"):
		zoom += Vector2(0.001,0.001) * zoom_multiplayer
	if Input.is_action_pressed("MouseWheelUp"):
		zoom -= Vector2(0.001,0.001) * zoom_multiplayer
