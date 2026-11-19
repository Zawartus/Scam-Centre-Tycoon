class_name ScamStep
extends Resource

## Sytuacja / wypowiedź klienta, na którą gracz reaguje.
@export_multiline var prompt: String
@export var choices: Array[ScamChoice] = []
