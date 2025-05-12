extends Area2D

signal vida_dada  # Declaración de la señal en el código de ObjetoVida.gd
# Controla si el sonido ya fue reproducido

func _on_objeto_vida_body_entered(body):
	if body.is_in_group("player"):  # Verifica que el jugador esté en el grupo adecuado
		
		Manejo.life += 3  # Incrementa la vida del jugador
		body.vida()  # Actualiza la UI de vida si es necesario
		emit_signal("vida_dada")  # Emite la señal de que la vida fue dada
		queue_free()  # Elimina el objeto de vida después de que el jugador lo haya tocado
