
extends Resource
class_name WorkerData

@export var employee_id: int = 0
@export var employee_name: String = "Nowy pracownik"
@export var job: String = "Bez stanowiska"

# Umiejętności
@export_range(0, 100) var praca_pod_presja: int = 50
@export_range(0, 100) var sila_perswazji: int = 50
@export_range(0, 100) var teamwork: int = 50

# Potrzeby
@export_range(0, 100) var komfort: float = 100.0
@export_range(0, 100) var energy: float = 100.0

# Finanse
@export var salary: int = 100

# Praca
@export var is_hired: bool = false
@export var workplace_id: int = -1
