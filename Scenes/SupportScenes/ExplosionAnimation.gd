extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#set_global_position(get_parent().get_global_position())
	get_node("MortarExplosion").play("Explode")
