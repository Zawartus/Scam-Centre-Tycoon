extends Node2D

@onready var grid: GridContainer = $Grid_Node_2D/Grid

const OBJECT = preload("uid://dnrhquilka871")

var gridSize: Vector2
var object
var targetCell
var objectCells
var isValid = false

func _ready() -> void:
	gridSize = Vector2(grid.cellWidth,grid.cellHeight)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("LeftMouse") and not object:
		var newPlacemnt = OBJECT.instantiate()
		add_child(newPlacemnt)
		newPlacemnt.global_position = get_global_mouse_position()
		object = newPlacemnt
	elif Input.is_action_just_pressed("LeftMouse") and isValid:
		_place_placement(objectCells)

func _on_grid_gui_input(event: InputEvent) -> void:
	if not object: return
	
	var newTargetCell = _get_target_cell()
	
	if newTargetCell and newTargetCell != targetCell:
		targetCell = newTargetCell
		object.global_position = targetCell.get_global_transform() * (targetCell.size / 3)		
		_reset_highlight()
		objectCells = _get_object_cells()
		isValid = _check_and_highlight_cells(objectCells)

	var center = targetCell.get_global_transform() * (targetCell.size / 2)
	print("rect: ", object.rect.size, "  komórka: ", targetCell.size, "  cellWidth: ", grid.cellWidth)
func _get_target_cell(_unused = null):
	var local_mouse := grid.get_local_mouse_position()
	for child:Control in grid.get_children():
		if child.get_rect().has_point(local_mouse):
			return child
	pass # Replace with function body.

func _reset_highlight():
	for child:Control in grid.get_children():
		child.change_color(Color(0.5,0.5,0.5,0.5))


func _get_object_cells() -> Array:
	
	var cells = [] 
	var footprint := Rect2(targetCell.position, object.rect.size) 
	
	for child:Control in grid.get_children():
		if child.get_rect().intersects(footprint):
			cells.append(child)
	return cells

func _check_and_highlight_cells(objectCells: Array):
	
	var isValid = true
	var objectCellCount = ceili(object.rect.size.x / gridSize.x - 0.001) * ceili(object.rect.size.y / gridSize.y - 0.001)


	if objectCellCount != objectCells.size():
		isValid = false
	
	for cell in objectCells:
		if cell.full:
			isValid = false
			cell.change_color(Color.RED)
		else:
			cell.change_color(Color.GREEN)
	
	return isValid

func _place_placement(objectCells):


	object.set_on_place()
	object = null
	isValid = false
	
	for cell in objectCells:
		cell.full = true
		
	_reset_highlight()
