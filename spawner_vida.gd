extends Node2D

export(PackedScene) var objeto_vida_scene  # Escena del objeto de vida
export var spawn_interval: float = 5.0  # Intervalo de aparición de objetos de vida
export var max_objetos_vida: int = 4  # Número máximo de objetos de vida en la escena

var current_objetos_vida: int = 0  # Contador de objetos de vida activos
onready var timer = $Timer_vida  # Temporizador para generar objetos de vida

# Limites de la pantalla (viewport) para generar posiciones aleatorias
var viewport_size: Vector2

func _ready():
	print("Spawner de vida listo.")
	viewport_size = get_viewport().get_visible_rect().size  # Obtener el tamaño visible del viewport
	timer.start(spawn_interval)  # Comienza el temporizador


func _on_Timer_vida_timeout():
	if current_objetos_vida < max_objetos_vida:
		spawn_objeto_vida()

func spawn_objeto_vida():
	if objeto_vida_scene:  # Verifica que la escena esté asignada
		var objeto_vida = objeto_vida_scene.instance()  # Instancia un nuevo objeto de vida
		
		# Genera una posición aleatoria dentro del área visible
		var viewport_size = get_viewport().get_visible_rect().size  # Asegura límites visibles
		objeto_vida.position = Vector2(rand_range(0, get_viewport().size.x), rand_range(0, 50))  # Ajuste en la posición
		
		# Añade el objeto de vida a la escena
		add_child(objeto_vida)
		current_objetos_vida += 1

		# Conecta la señal de que la vida fue dada
		objeto_vida.connect("vida_dada", self, "_on_Vida_dada")
	else:
		print("Error: 'objeto_vida_scene' no está asignada.")


func _on_Vida_dada():
	current_objetos_vida -= 1  # Reduce el contador cuando se recoja el objeto de vida
	print("Objeto de vida recogido. Restan: ", current_objetos_vida)






