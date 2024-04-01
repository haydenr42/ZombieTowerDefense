extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var frame_number = 2
	play("Flame")
	while(frame<=4):
		self.frame = frame_number
		await (get_tree().create_timer(0.5)).timeout
		frame_number += 1


func _on_animation_finished():
	queue_free()
