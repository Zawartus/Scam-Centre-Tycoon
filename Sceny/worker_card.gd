
extends Control

var worker_data: WorkerData
var is_candidate: bool = true



# Dane osobowe
@onready var name_worker: Label = $Margin/MainColumn/TopSection/LeftContent/Header/PersonalInfo/Name
@onready var age: Label = $Margin/MainColumn/TopSection/LeftContent/Header/PersonalInfo/Age
@onready var origin: Label = $Margin/MainColumn/TopSection/LeftContent/Header/PersonalInfo/Origin
@onready var work_position: Label = $Margin/MainColumn/TopSection/LeftContent/Header/PersonalInfo/Work_position

# Opis i portret
@onready var portrait: TextureRect = $Margin/MainColumn/TopSection/LeftContent/Header/Portrait
@onready var description: Label = $Margin/MainColumn/TopSection/LeftContent/Header/Description

# Statystyki
@onready var h_bar: ProgressBar = $Margin/MainColumn/TopSection/LeftContent/Stats/Hapiness/H_bar

@onready var pressure_level: ProgressBar = $Margin/MainColumn/TopSection/LeftContent/Stats/Pressure/Pressure_level
@onready var persuasion_bar: ProgressBar = $Margin/MainColumn/TopSection/LeftContent/Stats/Persuasion/Persuasion_bar

# Zatrudnianie
@onready var button: Button = $Margin/MainColumn/BottomRow/Hire/HireColumn/Button
@onready var salary: Label = $Margin/MainColumn/BottomRow/Hire/HireColumn/Salary


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
