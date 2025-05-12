extends Node2D

export(PackedScene) var enemy_scene  # Escena del enemigo a instanciar
export var spawn_interval: float = 3.0  # Intervalo de aparición de enemigos (en segundos)
export var max_enemies: int = 30  # Número máximo de enemigos en la escena
export var level_up_every: int = 5  # Cantidad de spawns antes de incrementar el nivel
export var level_increase: float = 1.2  # Incremento porcentual de fuerza

var current_enemies: int = 0  # Contador de enemigos activos
var enemies_spawned: int = 0  # Total de enemigos generados
var enemy_level: float = 1.0  # Nivel actual de fuerza de los enemigos

onready var timer = $Timer  # Temporizador para generar enemigos

func _ready():
	timer.start(spawn_interval)

func _on_Timer_timeout():
	if current_enemies < max_enemies:
		spawn_enemy()
		current_enemies += 1
		enemies_spawned += 1
		
		# Incrementa el nivel de fuerza cada "level_up_every" enemigos generados
		if enemies_spawned % level_up_every == 0:
			enemy_level *= level_increase  # Incrementa el nivel
			print("¡Nivel de enemigos incrementado! Nivel actual:", enemy_level)

func spawn_enemy():
	if enemy_scene:
		var enemy = enemy_scene.instance()
		
		# Ajusta atributos del enemigo según el nivel
		enemy.life *= enemy_level  # Incrementa la vida
		enemy.speed *= enemy_level  # Incrementa la velocidad (si es aplicable)
		
		# Coloca al enemigo en una posición aleatoria
		enemy.position = Vector2(rand_range(0, get_viewport().size.x), 0)
		add_child(enemy)
	else:
		print("Error: 'enemy_scene' no está configurado correctamente.")
