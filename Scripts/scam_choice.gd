class_name ScamChoice
extends Resource

## Tekst przycisku, który widzi gracz.
@export var text: String
## Zmiana podejrzenia klienta po wybraniu tej opcji (może być ujemna).
@export var suspicion_delta: int = 0
## Reakcja klienta pokazywana po wyborze (opcjonalna).
@export_multiline var client_reaction: String
