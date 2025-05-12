extends KinematicBody2D

# Variables del enemigo
var life: float = 3.0
var target = null
var speed: float = 100.0
onready var animated_sprite = $AnimatedSprite
var animation = false
var coup = false

# El enemigo es golpeado por el jugador
func herir():
	if life > 0:
		animation = true
		animated_sprite.play("herir")
		print("herir")
		$ale.play()
	else:
		$aleKO.play()

# Cuando termina la animación de "herir" o "KO"
func _on_AnimatedSprite_animation_finished():
	if life == 0 or life <= 0 :
		animation = true
		animated_sprite.play("KO")
		$tiempoKO.start()  # Comienza el tiempo para eliminarlo
	else:
		animation = false
		animated_sprite.play("parado")

# Desplazamiento del enemigo
func _physics_process(delta):
	if target:
		var velocity = global_position.direction_to(target.global_position).normalized()
		move_and_collide(velocity * speed * delta)  # Mueve al enemigo hacia el jugador
		
		# Solo se reproduce la animación "caminar" si no está en otro estado (como herido)
		if animation == false:
			$AnimatedSprite.play("caminar")
	else:
		# Si no hay un objetivo, el enemigo puede estar parado
		if not animation:
			$AnimatedSprite.play("parado")

	# Orientación del enemigo según la posición del jugador
	if target and global_position.x >= target.global_position.x:
		$AnimatedSprite.flip_h = false
	elif target and global_position.x <= target.global_position.x:
		$AnimatedSprite.flip_h = true

# Golpes dados por el enemigo en las áreas de colisión

	for body in $areaizquierda.get_overlapping_bodies():
		if body.is_in_group("player"):  # Asegúrate de que sea un jugador
			if not coup:
				animation = true
				coup = true
				$tiempogolpe.start()  # Temporizador para reiniciar el golpe
				$ale.play()
				$AnimatedSprite.play("golpe")
				
				if body.has_method("herir"):  # Verifica si el objeto tiene el método "herir"
					body.herir()
					Manejo.life -=1  # Llama a Manejo para reducir la vida global
					print("Golpe dado, vida del jugador: ", Manejo.life)
				else:
					print("Advertencia: El objeto detectado no tiene el método 'herir'")




# Detección cuando el jugador entra o sale del área del enemigo
func _on_deteccion_body_entered(body):
	print(body.name)
	if body.name == "personaje":  # Si el cuerpo es el jugador
		target = body  # Asigna al jugador como objetivo

func _on_deteccion_body_exited(body):
	if body.name == "personaje":  # Si el jugador sale del área del enemigo
		target = null  # Elimina el objetivo

# Acción cuando el enemigo es destruido
func _on_tiempoKO_timeout():
	queue_free()  # Elimina al enemigo de la escena

# Acción cuando el tiempo de golpe termina
func _on_tiempogolpe_timeout():
	coup = false  # Restablece el golpe
	animation = false  # Restablece la animación
