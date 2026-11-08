extends Node2D

class_name Worker

@export var data: WorkerData

func _ready() -> void:
	if data == null:
		push_warning("Nie przypisano pracownika") #pokazuje ostrzezenie w debuggerze
		return
		
	print("Pracownik", data.nazwa_pracownika)
	print("Stawnowisko", data.stan_zatrudnienia)

func zmiana_szczescia(amount:float) -> void:
	if data == null:
		return
	
	data.szczescie = clampf(#ograniczamy liczbe do danego przedziału
		data.szczescie +amount,#wartosc
		0.0,#minimum
		100.0#maksimum
	)
