extends Node

var life = 10

func _process(delta):
	life = clamp(life, 0, 10)

func reiniciar_vida():
	life = 10 #restablece la vida
