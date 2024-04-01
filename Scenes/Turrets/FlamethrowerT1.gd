extends "res://Scenes/Turrets/Turrets.gd"

@onready var impact_area = get_node("Turret/Muzzle")
var flame = preload("res://Scenes/SupportScenes/Flame.tscn")

func fire():
	ready_to_fire = false
	ignite()
	enemy.on_hit(GameData.tower_data["FlamethrowerT1"]["damage"])
	await(get_tree().create_timer(GameData.tower_data["FlamethrowerT1"]["rof"])).timeout
	ready_to_fire = true

func ignite():
	var new_flame = flame.instantiate()
	impact_area.add_child(new_flame)
	


