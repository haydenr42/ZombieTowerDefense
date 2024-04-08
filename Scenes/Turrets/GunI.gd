extends "res://Scenes/Turrets/Turrets.gd"

var cooldown = false

func fire():
	ready_to_fire = false
	flash()
	#add bullet recylcling to animation
	$AudioStreamPlayer.play()
	enemy.on_hit(GameData.tower_data[type]["damage"])
	await(get_tree().create_timer(GameData.tower_data[type]["rof"])).timeout
	ready_to_fire = true
	
func flash():
	if self.type == "GunI" or self.type == "GunIII":
		get_node("AnimationPlayer").play("Fire")
	elif self.type == "GunII":
		if not cooldown:
			get_node("AnimationPlayer").play("Fire")
			cooldown = true
		else:
			get_node("AnimationPlayer2").play("Fire2")
			cooldown = false
		
	
func on_upgraded():
	$Turret/Muzzle/MuzzleFlash.position.y = 10
	if(self.type=="GunIII"):
		remove_child($Turret/Muzzle/MuzzleFlash2)
		$Turret/Muzzle/MuzzleFlash.position.y = 1
		
	
