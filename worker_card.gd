
extends PanelContainer

var worker_data: WorkerData
var is_candidate: bool = true

@onready var name_label: Label = $HBoxContainer/VBoxContainer/NameLabel #przypisujemy wartosci
@onready var stats_label: Label = $HBoxContainer/VBoxContainer/StatsLabel
@onready var action_button: Button = $HBoxContainer/ActionButton


func _ready() -> void:
	action_button.pressed.connect(_on_action_button_pressed)
	update_ui()


func setup(worker: WorkerData, candidate: bool) -> void:
	worker_data = worker
	is_candidate = candidate

	if is_node_ready():
		update_ui()


func update_ui() -> void:
	if worker_data == null:
		return

	name_label.text = worker_data.employee_name

	stats_label.text = "%s | praca_pod_presja: %d | Miesięczny koszt: %d $" % [
		worker_data.job,
		worker_data.praca_pod_presja,
		worker_data.salary
	]

	if is_candidate:
		action_button.text = "Zatrudnij"
	else:
		action_button.text = "Zwolnij"


func _on_action_button_pressed() -> void:
	if worker_data == null:
		return

	if is_candidate:
		WorkerManager.hire_worker(worker_data)
	else:
		WorkerManager.fire_worker(worker_data)
