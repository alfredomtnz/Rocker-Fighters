extends Control

enum MenuState {NULL, INTRO, MENU, SELECT }
func _on_reintentar_pressed():
	var current_scene = get_tree().current_scene.filename

	# Verifica la escena actual y cambia a la otra
	if current_scene == "res://escena/ecena_pink.tscn":
		get_tree().change_scene("res://escena/escena_scorpions.tscn")
	else:
		get_tree().change_scene("res://escena/ecena_pink.tscn")

	Manejo.reiniciar_vida()




func _on_salir_pressed():
	get_tree().quit()  # Salir del juego


func _on_seleccionNivel_pressed():
	# Detén la música
	var music_player = $gameover/gameovermusic
	if music_player:
		music_player.stop()
	# Carga la escena del menú
	var menu_scene_resource = preload("res://escena/menu.tscn")
	
	# Instancia la escena
	var menu_scene_instance = menu_scene_resource.instance()
	
	# Ajusta el estado del menú antes de agregarlo al árbol
	menu_scene_instance.menu_state = MenuState.SELECT
	menu_scene_instance._open_select()
	
	# Cambia la escena actual por la nueva instancia
	get_tree().root.add_child(menu_scene_instance)  # Opcional si necesitas agregarla al árbol manualmente
	get_tree().current_scene = menu_scene_instance


