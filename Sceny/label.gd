extends Label

var money: int = 0

#wyswietlanie i zmiana zmiennej do wyswietlenia
func _ready() -> void:
	text = str(money)
	await get_tree().create_timer(1.2).timeout
	for i in range(100):
		text = str(money + i)
		await get_tree().create_timer(0.2).timeout
	text = str(Test.pieniadz) #dziala
