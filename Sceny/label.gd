extends Label

var money = 10000

func _ready() -> void:
	text = str(money)
	await get_tree().create_timer(5.0).timeout
	for j in range(100):
		for i in range(10):
			text = str(money + i)
