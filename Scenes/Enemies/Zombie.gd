extends "res://Scenes/Enemies/Enemies.gd"


func on_hit(damage):
	if $Burning.is_playing() == false:
		var rand = (randi() % 6)
		if(rand==4):
			$Screech.play()
	impact()
	hp-= damage
	health_bar.value = hp
	if hp<=0:
		on_destroy()

func burning():
	if $Burning.is_playing() == false:
		$Burning.play()
	
