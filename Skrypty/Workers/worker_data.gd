
extends Resource
class_name WorkerData

#opisowe rzeczy
@export var employee_id: int = 0
@export_range(16,100) var age: int = 25
@export var origin: String = "Polska"
@export var employee_name: String = "Nowy pracownik"
@export var job: String = "Bez stanowiska"
@export_multiline var description: String = "Od dzieciaka marzylem zeby zostac pracownikem w 
 waszym call center!"

#portret pracownika
@export var portrait: Texture2D

#Umiejętności
@export_range(0, 100) var praca_pod_presja: int = 50
@export_range(0, 100) var sila_perswazji: int = 50
@export_range(0, 100) var hapiness: int = 50

# Potrzeby
@export_range(0, 100) var komfort: float = 100.0
@export_range(0, 100) var energy: float = 100.0

# Finanse
@export var salary: int = 100

# Praca
@export var is_hired: bool = false
@export var workplace_id: int = -1
