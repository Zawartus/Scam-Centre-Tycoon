extends Control
## Scena: Control z węzłami (każdy z "Unique Name in Scene" = %Nazwa):
##   %PromptLabel    RichTextLabel  (tekst klienta, efekt maszyny do pisania)
##   %ChoicesBox     VBoxContainer  (przyciski wyborów tworzone w kodzie)
##   %SuspicionBar   ProgressBar    (podejrzenie klienta)
##   %ReactionLabel  Label          (reakcja klienta po wyborze)
##   %ResultLabel    Label          (wynik na końcu)
##   %CloseButton    Button         (ukryty do końca sekwencji)

signal closed(unlocked_new_scam: bool)

const TYPE_SPEED := 0.02       # sekundy na znak
const REACTION_PAUSE := 1.4    # ile trwa pokazanie reakcji przed kolejnym krokiem

@onready var prompt_label: RichTextLabel = %PromptLabel
@onready var choices_box: VBoxContainer = %ChoicesBox
@onready var suspicion_bar: ProgressBar = %SuspicionBar
@onready var reaction_label: Label = %ReactionLabel
@onready var result_label: Label = %ResultLabel
@onready var close_button: Button = %CloseButton

var _encounter: ScamEncounter
var _was_unlocked_before: bool = false
var _reported: bool = false


func _ready() -> void:
	close_button.hide()
	result_label.text = ""
	reaction_label.text = ""
	close_button.pressed.connect(func(): closed.emit(not _was_unlocked_before and not _reported))


func run(def: ScamDefinition) -> void:
	_was_unlocked_before = ScamManager.is_unlocked(def)
	suspicion_bar.max_value = def.max_suspicion
	suspicion_bar.value = 0

	_encounter = ScamManager.start_encounter(def)
	_encounter.step_started.connect(_on_step_started)
	_encounter.choice_made.connect(_on_choice_made)
	_encounter.suspicion_changed.connect(_on_suspicion_changed)
	_encounter.finished.connect(_on_finished)
	_encounter.start()


func _on_step_started(step: ScamStep, _index: int) -> void:
	_clear_choices()
	reaction_label.text = ""
	prompt_label.text = step.prompt
	prompt_label.visible_ratio = 0.0

	var duration := maxf(0.3, step.prompt.length() * TYPE_SPEED)
	var tween := create_tween()
	tween.tween_property(prompt_label, "visible_ratio", 1.0, duration)
	await tween.finished

	for i in step.choices.size():
		var button := Button.new()
		button.text = step.choices[i].text
		button.pressed.connect(_on_choice_pressed.bind(i))
		choices_box.add_child(button)


func _on_choice_pressed(index: int) -> void:
	for b in choices_box.get_children():
		(b as Button).disabled = true
	_encounter.choose(index)
	await get_tree().create_timer(REACTION_PAUSE).timeout
	_encounter.advance()


func _on_choice_made(choice: ScamChoice) -> void:
	reaction_label.text = choice.client_reaction


func _on_suspicion_changed(value: int, _max_value: int) -> void:
	var tween := create_tween()
	tween.tween_property(suspicion_bar, "value", value, 0.4)
	# bar robi się czerwony wraz z podejrzeniem
	var ratio := float(value) / suspicion_bar.max_value
	tween.parallel().tween_property(suspicion_bar, "modulate", Color.WHITE.lerp(Color.RED, ratio), 0.4)


func _on_finished(reported: bool, payout: int, suspicion: int) -> void:
	_reported = reported
	_clear_choices()
	prompt_label.text = ""
	if reported:
		result_label.text = "Klient zgłosił sprawę na policję! Zysk: 0"
	else:
		result_label.text = "Udało się! Zysk: %d (podejrzenie: %d)" % [payout, suspicion]
		if not _was_unlocked_before:
			result_label.text += "\nOdblokowano nowy scam – możesz go przypisać pracownikowi."
	close_button.show()


func _clear_choices() -> void:
	for c in choices_box.get_children():
		c.queue_free()
