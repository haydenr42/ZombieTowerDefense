extends PathFollow2D


signal deal_base_damage(damage)
signal on_death(reward)

@onready var type = self.name.rstrip('0123456789')
var hp
var speed
var base_damage
var kill_reward 
@onready var health_bar = get_node("HealthBar")
@onready var impact_area = get_node("Impact")
var machine_impact = preload("res://Scenes/SupportScenes/Explosion.tscn")
var organic_impact = preload("res://Scenes/SupportScenes/Splatter.tscn")


func _ready():
	randomize()
	hp = GameData.enemy_data[type]["hp"]
	speed = GameData.enemy_data[type]["speed"]
	base_damage = GameData.enemy_data[type]["penalty"]
	kill_reward = GameData.enemy_data[type]["reward"]
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_top_level(true)

func _physics_process(delta):
	if progress_ratio == 1.0:
		emit_signal("deal_base_damage", base_damage)
		queue_free()
	move(delta)
	
func move(delta):
	set_progress(get_progress()+speed*delta)
	health_bar.position = position - Vector2(30,30)
	
func on_hit(damage):
	impact();
	hp-= damage
	health_bar.value = hp
	if hp<=0:
		on_destroy()

func impact():
	var x_pos = randi() % 31
	var y_pos = randi() % 31
	var impact_location
	var new_impact
	if GameData.enemy_data[type]["type"] == "Machine":
		new_impact = machine_impact.instantiate()
		impact_location = Vector2(x_pos, y_pos)
	elif GameData.enemy_data[type]["type"] == "Organic":
		new_impact = organic_impact.instantiate()
		impact_location = Vector2(0.7 * x_pos,0.7 * y_pos)
	new_impact.position = impact_location
	impact_area.add_child(new_impact)
	
func on_destroy():
	get_node("CharacterBody2D").queue_free()
	emit_signal("on_death", kill_reward)
	await(get_tree().create_timer(0.2)).timeout
	self.queue_free()

	
	
