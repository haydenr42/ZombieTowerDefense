extends Node2D

var type
var enemy_array = []
var built = false
var enemy
var ready_to_fire = true

var inspect_button = preload("res://Scenes/Turrets/inspect.tscn")
var sell_button = preload("res://Scenes/Turrets/sell_button.tscn")

func _ready():
	if built:
		var inspect_button_instance = inspect_button.instantiate()
		add_child(inspect_button_instance)
		self.get_node("Range/CollisionShape2D").get_shape().radius =0.5 * GameData.tower_data[type]["range"]
		
func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		if not get_node("AnimationPlayer").is_playing():
			turn()
		if ready_to_fire:
			fire()
	else:
		enemy = null
		
	
func turn():
	get_node("Turret").look_at(enemy.position)
	
func select_enemy():
	var enemy_progress_array = []
	for i in enemy_array:
		enemy_progress_array.append(i.progress)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]
	
func fire():
	ready_to_fire = false
	enemy.on_hit(GameData.tower_data[type]["damage"])
	await(get_tree().create_timer(GameData.tower_data[type]["rof"])).timeout
	ready_to_fire = true

func _on_range_body_entered(body):
	enemy_array.append(body.get_parent())
	

func _on_range_body_exited(body):
	enemy_array.erase(body.get_parent())
	
func on_inspect_pressed():
	var sell_button_instance = sell_button.instantiate()
	add_child(sell_button_instance)
	
func on_sell_pressed():
	queue_free()
	get_parent().get_parent().get_parent().update_balance(GameData.tower_data[type]["cost"] / 2) 
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel"):
		delete_sell()
		
func delete_sell():
	if get_node_or_null("SellButton"):
		get_node("SellButton").queue_free()
		
	
	
