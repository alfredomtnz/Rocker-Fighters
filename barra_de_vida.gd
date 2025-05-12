extends Control

func _process(delta):
	match Manejo.life:
		10:
			$AnimatedSprite.play("10")
		9:
			$AnimatedSprite.play("9")
		8:
			$AnimatedSprite.play("8")
		7:
			$AnimatedSprite.play("7")
		6:
			$AnimatedSprite.play("6")
		5:
			$AnimatedSprite.play("5")
		4:
			$AnimatedSprite.play("4")
		3:
			$AnimatedSprite.play("3")
		2:
			$AnimatedSprite.play("2")
		1:
			$AnimatedSprite.play("1")

