extends "res://Scenes/Enemies/Enemies.gd"

func on_hit(damage):
	var rand = (randi() % 5)
	if(rand==4):
		$Screech.play()
	impact()
	hp-= damage
	health_bar.value = hp
	if hp<=0:
		on_destroy()
