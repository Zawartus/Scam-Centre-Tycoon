class_name ScamEncounter
extends RefCounted
## Jedno interaktywne podejście do scamu (pierwszy raz, z wyborami gracza).
## Logika jest oddzielona od UI: UI słucha sygnałów i woła choose() / advance().

signal step_started(step: ScamStep, index: int)
signal choice_made(choice: ScamChoice)
signal suspicion_changed(value: int, max_value: int)
signal finished(reported: bool, payout: int, suspicion: int)

var definition: ScamDefinition
var suspicion: int = 0

var _step_index: int = -1
var _awaiting_advance: bool = false
var _done: bool = false
var _rng := RandomNumberGenerator.new()


func _init(def: ScamDefinition) -> void:
	definition = def
	_rng.randomize()


func start() -> void:
	advance()


## Gracz wybrał opcję. Zmienia podejrzenie, ale NIE przechodzi dalej –
## UI najpierw odgrywa animację, a potem woła advance().
func choose(choice_index: int) -> void:
	if _done or _awaiting_advance:
		return
	var step := definition.steps[_step_index]
	var choice := step.choices[choice_index]
	suspicion = clampi(suspicion + choice.suspicion_delta, 0, definition.max_suspicion)
	_awaiting_advance = true
	choice_made.emit(choice)
	suspicion_changed.emit(suspicion, definition.max_suspicion)


func advance() -> void:
	if _done:
		return
	_awaiting_advance = false
	if suspicion >= definition.max_suspicion:
		_finish()
		return
	_step_index += 1
	if _step_index >= definition.steps.size():
		_finish()
		return
	step_started.emit(definition.steps[_step_index], _step_index)


func _finish() -> void:
	_done = true
	var reported := definition.roll_report(suspicion, _rng)
	var payout := 0 if reported else definition.payout_for(suspicion)
	finished.emit(reported, payout, suspicion)
