extends Node2D

var pieniadz: int = 10000
#umiem globalne zmienne
func _ready():
	LabelGlobal.money = 100
	print(LabelGlobal.money)
	var lab = Label.new()
	lab.text = "10000000000"
	add_child(lab)
