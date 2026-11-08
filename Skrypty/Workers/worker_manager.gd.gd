extends Node

#dostepni kandydaci
var kandydaci: Array[WorkerData] = []

#aktualnie zatrudnieni pracownicy
var pracownicy: Array[WorkerData] =[]

#Id dla kazdego pracownika(kazdy bedzie mial unikalne ID)
var next_worker_id: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#testowi kandydaci narazie
	dodawanie_kandydata("Joshua", "Obsługa klienta", 80, 120)

func dodawanie_kandydata(
	nazwa_pracownika: String,
	praca: String,
	cos: int,
	salary: int
) -> void:
	var worker := WorkerData.new()
	worker.ID_pracownika = next_worker_id
	next_worker_id += 1

	worker.nazwa_pracownika = nazwa_pracownika
	worker.praca = praca
	worker.cos = cos
	worker.salary = salary
	
	kandydaci.append(worker)
	
	
func hire_worker(worker: WorkerData) -> void:
	pass

func fire_workers(worker: WorkerData) -> void:
	pass
	


	
