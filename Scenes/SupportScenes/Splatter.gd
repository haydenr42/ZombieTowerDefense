extends Sprite2D

func _ready():
	await(get_tree().create_timer(0.25)).timeout
	queue_free()
