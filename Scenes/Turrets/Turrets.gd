extends Node2D

var type
var tower_level
var enemy_array = []
var built = false
var enemy
var ready_to_fire = true

var inspect_button = preload("res://Scenes/Turrets/inspect.tscn")
var sell_button = preload("res://Scenes/Turrets/SellButton.tscn")
var turret_info = preload("res://Scenes/UIScenes/TurretInfo.tscn")


func _ready():
	if built:
		tower_level = 1
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
	get_parent().get_parent().get_parent().remove_buttons()
	if not get_node_or_null("TurretInfo"):
		var turret_info_instance = turret_info.instantiate()
		add_child(turret_info_instance)
		turret_info_instance.set_global_position(Vector2(225, 600))
		turret_info_instance.type = type
	if not get_node_or_null("range"):
		var range_texture = Sprite2D.new()
		var scaling = GameData.tower_data[type]["range"] / 600.0
		range_texture.scale = Vector2(scaling,scaling)
		var texture = load("res://Assets/UI/range_overlay.png")
		range_texture.texture = texture
		#range_texture.modulate = Color("1fa23c91")
		range_texture.name = "range"
		add_child(range_texture)
		move_child(range_texture,0)
	
func on_sell_pressed():
	queue_free()
	get_parent().get_parent().get_parent().update_balance(GameData.tower_data[type]["cost"] / 2) 
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") or event.is_action_released("ui_accept"):
		delete_buttons()
		
func delete_buttons():
	if get_node_or_null("TurretInfo"):
		$TurretInfo.queue_free()
	if(get_node_or_null("range")):
		$range.queue_free()
		
	
	
