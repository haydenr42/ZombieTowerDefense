extends "res://Scenes/Enemies/Enemies.gd"

func _ready():
	randomize()
	hp = GameData.enemy_data[type]["hp"]
	speed = GameData.enemy_data[type]["speed"]
	base_damage = GameData.enemy_data[type]["penalty"]
	kill_reward = GameData.enemy_data[type]["reward"]
	health_bar.max_value = hp
	health_bar.value = hp
	health_bar.set_as_top_level(true)
	$AnimatedSprite2D.play("default")
