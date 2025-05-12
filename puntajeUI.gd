extends Control

var puntos: int = 0  # Puntaje total
var combo: int = 1  # Multiplicador de combo
var combo_timeout: float = 2.0  # Tiempo límite para mantener el combo (en segundos)
var combo_timer: float = 0.0  # Temporizador interno para combo

onready var label_puntaje = $Label  # Referencia al nodo Label


func _process(delta):
	if combo_timer > 0:
		combo_timer -= delta  # Reduce el temporizador del combo
		if combo_timer <= 0:
			reset_combo()  # Reinicia el combo si el tiempo se acaba

# Incrementa puntos y maneja el combo
func agregar_puntos(base_puntos: int):
	puntos += base_puntos * combo  # Aplica el multiplicador
	combo += 1  # Aumenta el combo
	combo_timer = combo_timeout  # Reinicia el temporizador del combo
	actualizar_ui()


# Reinicia el combo
func reset_combo():
	combo = 1  # Vuelve al multiplicador base
	actualizar_ui()

# Actualiza el texto en la UI
func actualizar_ui():
	label_puntaje.text = "Puntaje: %d" % puntos
	
