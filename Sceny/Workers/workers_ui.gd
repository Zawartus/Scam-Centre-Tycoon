
extends Control

@export var employee_card_scene: PackedScene

@onready var candidate_list: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Taby/Kandydaci/CandidateList

@onready var worker_list: VBoxContainer = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Taby/Pracownicy/WorkerList


func _ready() -> void:
	WorkerManager.employees_changed.connect(refresh_lists)
	refresh_lists()
	print("=== WORKERS UI TEST ===")
	print("Kandydaci: ", WorkerManager.candidates.size())
	print("Pracownicy: ", WorkerManager.employees.size())
	print("Scena karty: ", employee_card_scene)
	print("Lista kandydatow: ", candidate_list)
	print("Lista pracownikow: ", worker_list)


func refresh_lists() -> void:
	#Usuwamy stare karty
	for child in candidate_list.get_children():
		child.queue_free()

	for child in worker_list.get_children():
		child.queue_free()

	if employee_card_scene == null:
		push_warning("Nie przypisano WorkerCard!")
		return

	#dodowanie karty kandydatow
	for worker in WorkerManager.candidates:
		var card = employee_card_scene.instantiate()
		candidate_list.add_child(card)
		card.setup(worker, true)
		
		print("Dodano karte: ", worker.employee_name)
		print("Liczba kart: ", candidate_list.get_child_count())

	#doddawanie karty zatrudnionych
	for worker in WorkerManager.employees:
		var card = employee_card_scene.instantiate()
		worker_list.add_child(card)
		card.setup(worker, false)
