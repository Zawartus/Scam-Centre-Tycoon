extends Resource

class_name WorkerData

@export var ID_pracownika: int = 0
@export var nazwa_pracownika: String = "Nowy pracownik"
@export var praca: String = "Bez stanowiska"

#skillsy
@export_range(0,100) var cos: int = 50
@export_range(0,100) var cos_1: int = 50
@export_range(0,100) var cos_2: int = 50

#wymagania
@export_range(0,100) var komfort: int = 50

#za ile zatrtudnic ich
@export var salary:int = 32000
