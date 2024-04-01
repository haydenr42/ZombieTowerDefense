extends Node

func _ready():
	load_main_menu()
	
func load_main_menu():
	get_node("MainMenu/M/VB/NewGame").pressed.connect(on_new_game_pressed)
	get_node("MainMenu/M/VB/Quit").pressed.connect(on_quit_pressed)
	
func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instantiate()
	game_scene.connect("game_finished", unload_game)
	call_deferred('add_child', game_scene)
	
func on_quit_pressed():
	get_tree().quit()

func unload_game(result):
	$GameScene.queue_free()
	var main_menu = load("res://Scenes/UIScenes/main_menu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()
