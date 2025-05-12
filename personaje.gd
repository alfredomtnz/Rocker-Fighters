extends KinematicBody2D

var speed : float = 200
var coup = false 
var fue_herido = false  # Cambiado para evitar conflicto con el nombre de la función
var combo = 0
var comboesp = 0
#onready var puntaje = get_node_or_null("/root/ecena_pink/puntajeUI")

onready var vida_audio = $vida




func _process(delta: float) -> void:
	var movement = Vector2()
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("caminar")
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
		$AnimatedSprite.flip_h = true 
		$AnimatedSprite.play("caminar")
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
		$AnimatedSprite.play("caminar")
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
		$AnimatedSprite.play("caminar")
	movement = movement.normalized()
	if movement != Vector2():
		move_and_slide(movement * speed)

	# Animaciones más fluidas
	if Input.is_action_just_released("ui_right"):
		$AnimatedSprite.play("parado")
		comboesp += 1
	if Input.is_action_just_released("ui_left"):
		$AnimatedSprite.play("parado")
		comboesp += 1
	if Input.is_action_just_released("ui_down"):
		$AnimatedSprite.play("parado")
	if Input.is_action_just_released("ui_up"):
		$AnimatedSprite.play("parado")

	# Gestión de golpes
	if Input.is_action_just_pressed("ui_accept") and $AnimatedSprite.flip_h == false and coup == false:
		if combo == 0:
			$AnimatedSprite.play("golpe")
			$Timer.start()
		if combo == 1:
			$AnimatedSprite.play("golpe2")
		if combo == 2:
			$AnimatedSprite.play("golpe3")
		if comboesp == 3:
			$AnimatedSprite.play("especialgolpe")
		coup = true  # Bloquea los golpes temporales
	
		var golpeo_enemigo = false  # Bandera para verificar si se golpeó a un enemigo
	
		
		combo += 1
		coup = true
		for body in $golpedroit.get_overlapping_bodies():
			if (body.get_collision_layer() == 2): 
				body.herir()
				body.life -= 1
				golpeo_enemigo = true
				if comboesp >=3 :
					body.life -=3
				if golpeo_enemigo:
					#puntaje.agregar_puntos(10)
					
					
					
					combo += 1
	if Input.is_action_just_pressed("ui_accept") and $AnimatedSprite.flip_h == true and coup == false:
		$AnimatedSprite.play("golpe")
		var golpeo_enemigo = false
	
		for body in $golpegauche.get_overlapping_bodies():
			if (body.get_collision_layer() == 2):
				body.herir()
				body.life -= 1
				coup = true
# gestion de patadas

	if Input.is_action_just_pressed("patada") and $AnimatedSprite.flip_h == false and coup == false:
		$AnimatedSprite.play("patada")
		var golpeo_enemigo = false
		for body in $piederecho.get_overlapping_bodies():
			if (body.get_collision_layer() == 2): 
				body.herir()
				body.life -= 2
				golpeo_enemigo = true
				coup = true
			
	if Input.is_action_just_pressed("patada") and $AnimatedSprite.flip_h == true and coup == false:
		$AnimatedSprite.play("patada")
		var golpeo_enemigo = false
		for body in $pieizquierdo.get_overlapping_bodies():
			if (body.get_collision_layer() == 2):
				body.herir()
				body.life -= 2
				golpeo_enemigo = true 
			if golpeo_enemigo:
				#puntaje.agregar_puntos(15)
				
				
				coup = true




# Función que se ejecuta después de la animación de KO
func _terminar_partida():
	print("El jugador ha sido derrotado.")
	var game_over_scene = load ("res://escena/gameover.tscn")
	get_tree().change_scene_to(game_over_scene)  # Terminar el juego o puedes reiniciar la escena con: get_tree().reload_current_scene()

func _on_AnimatedSprite_animation_finished():
	if Manejo.life <= 0:  # Solo si Manejo es un autoload
		$AnimatedSprite.play("KO")  # Cambiar a la animación KO
		coup = true
		  # Reproducir el sonido de KO (opcional)
		fue_herido = true  # Evitar que el jugador siga interactuando después de KO
		get_tree().create_timer(1.5).connect("timeout", self, "_terminar_partida")  # Esperar 2 segundos y luego terminar
	else:
		$AnimatedSprite.play("parado")
		coup = false
		fue_herido = false

func herir():
	fue_herido = true
	coup = true
	$AnimatedSprite.play("herir")
	

func _on_Timer_timeout():
	combo = 0
	comboesp = 0

func vida():
	if not vida_audio.playing:  # Verifica si el sonido no está reproduciéndose
		vida_audio.play()  # Reproduce el sonido si no está sonando
	else:
		vida_audio.stop()  # Detiene el sonido si ya está sonando



