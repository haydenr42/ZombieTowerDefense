extends Node2D

signal game_finished(result)

var map_node 

var build_mode= false
var build_valid = false 
var build_location
var build_type 

var current_wave = 0
var enemies_in_wave

var base_health = 100;

var level


@onready var balance = get_node("UI/HUD/InfoBar/H/Money")
var cash = 100;

func _ready():
	randomize()
	var map = load("res://Scenes/Maps/Map" + str(level) + ".tscn").instantiate()
	add_child(map)
	move_child(map, 0)
	balance.text = str(cash)
	map_node = get_node("Map" + str(level))
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	
func _process(delta):
	if build_mode:
		update_tower_preview()
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel"):
		if build_mode == true:
			cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

##
## Wave Functions
##
func start_next_wave():
	get_node("UI").update_wave_counter(current_wave)
	get_node("UI/HUD/RoundChange").play()
	var wave_data = retrieve_wave_data()
	if current_wave == 1:
		await (get_tree().create_timer(4)).timeout
	else:
		await (get_tree().create_timer(10)).timeout
	spawn_enemies(wave_data)

func retrieve_wave_data():
	var wave_data = GameData.wave_data[map_node.name]["wave" + str(current_wave)]
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instantiate()
		new_enemy.deal_base_damage.connect(on_base_damage)
		new_enemy.on_death.connect(on_kill)
		if(current_wave==1) || level==1:
			map_node.get_node("Path").add_child(new_enemy,true)
		else:
			map_node.get_node("Path2").add_child(new_enemy,true)
		await (get_tree().create_timer(i[1])).timeout

##
## Building Functions
##
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	for i in get_node("Map" + str(level) + "/Turrets").get_children():
		if i.get_node_or_null("SellButton"):
			i.get_node("SellButton").queue_free()
	if(cash >= GameData.tower_data[tower_type + "I"]["cost"]):
		build_type = tower_type + "I"
		build_mode = true 
		get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cell_tile_data(0, current_tile)==null:
		for t in get_node("Map" + str(level) + "/Turrets").get_children():
			if t.position == tile_position:
				get_node("UI").update_tower_preview(tile_position, "ef382d91")
				build_valid = false
				return
		get_node("UI").update_tower_preview(tile_position, "1fa23c91")
		build_valid = true 
		build_location = tile_position
	
	else:
		get_node("UI").update_tower_preview(tile_position, "ef382d91")
		build_valid = false

func cancel_build_mode():
	build_mode = false 
	build_valid = false 
	get_node("UI/TowerPreview").free()
	
func verify_and_build():
	if build_valid:
		var new_tower = load("res://Scenes/Turrets/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		new_tower.type = build_type
		new_tower.built = true
		map_node.get_node("Turrets").add_child(new_tower, true)
		cash -= GameData.tower_data[build_type]["cost"]
		balance.text = str(cash)
		
func on_base_damage(damage):
	base_health-=damage
	enemies_in_wave-=1
	if base_health <= 0:
		game_finished.emit("game_finished")
	else:
		get_node("UI").update_health_bar(base_health)
	check_wave_end()

func on_kill(reward):
	enemies_in_wave-=1
	update_balance(reward)
	check_wave_end()
	
func check_wave_end():
	if enemies_in_wave == 0:
		current_wave += 1
		if current_wave > GameData.wave_data[map_node.name]["wave_count"]:
			game_finished.emit("game_finished")
		else:
			start_next_wave()
			
func update_balance(money):
	cash+=money
	balance.text = str(cash)

