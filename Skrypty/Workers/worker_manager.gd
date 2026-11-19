
extends Node

signal employees_changed

# Dostępni kandydaci
var candidates: Array[WorkerData] = []

# Zatrudnieni pracownicy
var employees: Array[WorkerData] = []

# Unikalne ID dla każdego pracownika
var next_employee_id: int = 1

#wolni robole
var free_workers: int = 1


func _ready() -> void:
	# Przykładowi kandydaci
	add_candidate("Adam", "Caller", 80, 120)
	candidates[-1].portrait = preload("res://Assety zewnętrzne/Stas-bin/7414712add106b9653cf2922e2e81696.jpg")
	add_candidate("Kasia", "Caller", 65, 100)
	add_candidate("Marek", "Kierwonik", 50, 80)


func add_candidate(
	employee_name: String,
	job: String,
	praca_pod_presja: int,
	salary: int
) -> void:
	var worker := WorkerData.new()

	worker.employee_id = next_employee_id
	next_employee_id += 1

	worker.employee_name = employee_name
	worker.job = job
	worker.praca_pod_presja = praca_pod_presja
	worker.salary = salary

	candidates.append(worker)
	employees_changed.emit()


func hire_worker(worker: WorkerData) -> void:
	if not candidates.has(worker) :
		push_warning("Nie znaleziono kandydata!")
		return
	if free_workers > 1:
		candidates.erase(worker)

		worker.is_hired = true
		employees.append(worker)

		employees_changed.emit()
		free_workers -= 1

func fire_worker(worker: WorkerData) -> void:
	if not employees.has(worker):
		return

	employees.erase(worker)
	worker.is_hired = false

	employees_changed.emit()


func get_total_daily_salary() -> int:
	var total: int = 0

	for worker in employees:
		total += worker.salary

	return total


func get_employee_by_id(id: int) -> WorkerData:
	for worker in employees:
		if worker.employee_id == id:
			return worker

	return null
