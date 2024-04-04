extends Node

var level = 1

func _ready():
	load_main_menu()
	
func load_main_menu():
	get_node("MainMenu/M/VB/Play").pressed.connect(on_play_pressed)
	get_node("MainMenu/M/VB/Quit").pressed.connect(on_quit_pressed)

	
func on_play_pressed():
	get_node("MainMenu").queue_free()
	load_gamemode_select_scene()
	
func on_quit_pressed():
	get_tree().quit()

func unload_game(result):
	$GameScene.queue_free()
	var main_menu = load("res://Scenes/UIScenes/main_menu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()
	
func load_gamemode_select_scene():
	var gamemode_select_scene = load("res://Scenes/UIScenes/GameModeSelect.tscn").instantiate()
	call_deferred('add_child', gamemode_select_scene)

func on_campaign_pressed():
	load_level(level)
	
func on_endless_pressed():
	pass
	
func on_challenge_pressed():
	pass
	
func load_level(level):
	get_node("GameModeSelect").queue_free()
	var game_scene = load("res://Scenes/MainScenes/GameScene.tscn").instantiate()
	game_scene.connect("game_finished", unload_game)
	call_deferred('add_child', game_scene)
