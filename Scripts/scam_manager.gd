extends Node
## Autoload (Project Settings → Globals → Autoload, nazwa: ScamManager).

signal scam_unlocked(def: ScamDefinition)
signal scam_finished(def: ScamDefinition, reported: bool, payout: int, suspicion: int)

## id scamu -> true (do zapisu w save'ie)
var unlocked: Dictionary = {}

var money: int = 0  # podmień na swój system pieniędzy

var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	_rng.randomize()


func is_unlocked(def: ScamDefinition) -> bool:
	return unlocked.has(def.id)


## Pierwszy raz: interaktywna sekwencja. Zwraca ScamEncounter, którego słucha UI.
func start_encounter(def: ScamDefinition) -> ScamEncounter:
	var enc := ScamEncounter.new(def)
	enc.finished.connect(_on_encounter_finished.bind(def))
	return enc


func _on_encounter_finished(reported: bool, payout: int, suspicion: int, def: ScamDefinition) -> void:
	if not reported:
		money += payout
		if not is_unlocked(def):
			unlocked[def.id] = true
			scam_unlocked.emit(def)
	scam_finished.emit(def, reported, payout, suspicion)


## Przypisanie odblokowanego scamu pracownikowi.
func assign(employee: Employee, def: ScamDefinition) -> bool:
	if not is_unlocked(def):
		return false
	if not employee.assigned_scams.has(def.id):
		employee.assigned_scams.append(def.id)
	return true


## Automatyczny scam wykonywany przez pracownika (bez interakcji).
func run_auto(employee: Employee, def: ScamDefinition) -> void:
	if not employee.assigned_scams.has(def.id):
		return
	var suspicion := clampi(
		def.auto_base_suspicion - employee.scam_skill + _rng.randi_range(-10, 10),
		0, def.max_suspicion)
	var reported := def.roll_report(suspicion, _rng)
	var payout := 0 if reported else def.payout_for(suspicion)
	money += payout
	scam_finished.emit(def, reported, payout, suspicion)
