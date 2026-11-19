extends Node

@export var test_scam: ScamDefinition

@onready var ui = $ScamEncounterUI

func _ready() -> void:
	ui.closed.connect(_on_closed)
	ui.run(test_scam)

func _on_closed(unlocked_new: bool) -> void:
	print("Nowy scam odblokowany: ", unlocked_new, " | kasa: ", ScamManager.money)
