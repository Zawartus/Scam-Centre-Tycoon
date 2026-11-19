@tool
extends Node2D

signal cell_clicked(cell)    # taki sam sygnał, jak w grid.gd

@onready var grid = $Grid

func _ready() -> void:
	grid.cell_clicked.connect(cell_clicked.emit)
