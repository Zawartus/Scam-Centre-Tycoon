
extends PanelContainer

var worker_data: WorkerData
var is_candidate: bool = true

#dane osobowe jakies
@onready var name_worker: Label = $Margin/Main_row/Main_column/Header/PersonalInfo/Name
@onready var age: Label = $Margin/Main_row/Main_column/Header/PersonalInfo/Age
@onready var origin: Label = $Margin/Main_row/Main_column/Header/PersonalInfo/Origin
@onready var work_position: Label = $Margin/Main_row/Main_column/Header/PersonalInfo/Work_position

@onready var description: Label = $Margin/Main_row/Main_column/Header/Description
@onready var portrait: TextureRect = $Margin/Main_row/Main_column/Header/Portrait

#staty
@onready var h_bar: ProgressBar = $Margin/Main_row/Main_column/Stats/Hapiness/H_bar
@onready var pressure_level: ProgressBar = $Margin/Main_row/Main_column/Stats/Pressure/Pressure_level
@onready var persuasion_bar: ProgressBar = $Margin/Main_row/Main_column/Stats/Persuasion/Persuasion_bar

#zatrudnianie
@onready var button: Button = $Margin/Main_row/Main_column/Hire/HireColumn/Button
@onready var salary: Label = $Margin/Main_row/Main_column/Hire/HireColumn/Salary

func _ready() -> void:
	button.pressed.connect(_on_action_button_pressed)
	update_ui()


func setup(worker: WorkerData, candidate: bool) -> void:
	worker_data = worker
	is_candidate = candidate

	if is_node_ready():
		update_ui()


func update_ui() -> void:
	if worker_data == null:
		return

	name_worker.text = worker_data.employee_name
	age.text  = "Wiek: %d" % worker_data.age
	origin.text = "Pochodzenie: " + worker_data.origin
	work_position.text = worker_data.job
	description.text = worker_data.description
	
	#obrazek
	portrait.texture = worker_data.portrait
	
	#staty
	h_bar.value = worker_data.hapiness
	pressure_level.value = worker_data.praca_pod_presja
	persuasion_bar.value = worker_data.sila_perswazji
	
	if is_candidate:
		button.text = "Zatrudnij"
	else: button.text = "Zwolnij"

func _on_action_button_pressed() -> void:
	if worker_data == null:
		return

	if is_candidate:
		WorkerManager.hire_worker(worker_data)
	else:
		WorkerManager.fire_worker(worker_data)
