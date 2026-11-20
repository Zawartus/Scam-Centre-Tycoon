class_name ScamDefinition
extends Resource

@export var id: StringName
@export var display_name: String
@export var steps: Array[ScamStep] = []

@export_group("Pieniądze i ryzyko")
@export var base_payout: int = 1000
## Przy takim podejrzeniu klient zgłasza na policję na pewno (i scam kończy się od razu).
@export var max_suspicion: int = 100
## Do tego poziomu klient nigdy nie zgłosi.
@export var safe_suspicion: int = 30
## Jaką część base_payout dostajesz przy podejrzeniu na poziomie max (np. 0.25 = 25%).
@export_range(0.0, 1.0) var min_payout_ratio: float = 0.25

@export_group("Praca pracownika (po odblokowaniu)")
## Bazowe podejrzenie przy automatycznym scamie; umiejętność pracownika je obniża.
@export var auto_base_suspicion: int = 50


## Szansa zgłoszenia na policję: 0 do safe, potem rośnie liniowo do 1 przy max.
func report_chance(suspicion: int) -> float:
	if suspicion <= safe_suspicion:
		return 0.0
	return clampf(float(suspicion - safe_suspicion) / float(max_suspicion - safe_suspicion), 0.0, 1.0)


func roll_report(suspicion: int, rng: RandomNumberGenerator) -> bool:
	return rng.randf() < report_chance(suspicion)


## Im mniejsze podejrzenie, tym większa wypłata.
func payout_for(suspicion: int) -> int:
	var t := clampf(float(suspicion) / float(max_suspicion), 0.0, 1.0)
	return roundi(base_payout * lerpf(1.0, min_payout_ratio, t))
