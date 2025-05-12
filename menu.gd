extends Control


enum MenuState {NULL, INTRO, MENU, SELECT }

var menu_state = MenuState.INTRO


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		match menu_state:
			MenuState.INTRO:
				_open_menu()
				
			MenuState.MENU:
				_open_select()

func _open_menu() -> void:
	menu_state = MenuState.MENU
	get_node("intro").hide()
	get_node("menu").show()
	get_node("AnimationPlayer").play("menu")
	
func _open_select() -> void:
	menu_state = MenuState.SELECT
	get_node("menu").hide()
	get_node("seleccionar").show()


func _on_ButtonNivel1_pressed() -> void:
	Manejo.reiniciar_vida()

	if menu_state == MenuState.NULL:
		return
		
	menu_state = MenuState.NULL
	yield(get_tree().create_timer(0.5), "timeout")
	# get_tree().change_scene("res://escena/ecena_pink.tscn")  # Línea comentada
	var nivel1 = preload("res://escena/ecena_pink.tscn")
	get_tree().change_scene_to(nivel1)

func _on_ButtonNivel2_pressed():
	Manejo.reiniciar_vida()

	if menu_state == MenuState.NULL:
		return
		
	menu_state = MenuState.NULL
	yield(get_tree().create_timer(0.5), "timeout")
	# get_tree().change_scene("res://escena/ecena_pink.tscn")  # Línea comentada
	var nivel2 = preload("res://escena/escena_scorpions.tscn")
	get_tree().change_scene_to(nivel2)


func _on_ButtonNivel1_mouse_entered():
	get_node("seleccionar/nivel1").color = Color.yellow


func _on_ButtonNivel1_mouse_exited():
		get_node("seleccionar/nivel1").color = Color.white


func _on_ButtonNivel2_mouse_entered():
	get_node("seleccionar/nivel2").color = Color.yellow


func _on_ButtonNivel2_mouse_exited():
	get_node("seleccionar/nivel2").color = Color.white





