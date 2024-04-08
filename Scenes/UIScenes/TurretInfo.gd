extends ColorRect

var type
var upgraded_type
# Called when the node enters the scene tree for the first time.
func _ready():
	type = get_parent().name.rstrip("0123456789")
	if get_parent().tower_level <= 2:
		upgraded_type = type + "I"
	else:
		upgraded_type = type
	if(type != "CrossBowI"):
		$H/TurretTexture.texture = get_parent().get_node("Turret").texture
	$TextureRect/TowerName.text = type
	$H/V/DamageText.text = str(GameData.tower_data[type]["damage"])
	$H/V/FireRateText.text = str(1 / GameData.tower_data[type]["rof"])
	$H/V/RangeText.text = str(GameData.tower_data[type]["range"])
	$H/V/DamageTypeText.text = str(GameData.tower_data[type]["dmgtype"])
	$H/V2/UpDamageText.text = str(GameData.tower_data[upgraded_type]["damage"])
	$H/V2/UpFireRateText.text = str(1 / GameData.tower_data[upgraded_type]["rof"])
	$H/V2/UpRangeText.text = str(GameData.tower_data[upgraded_type]["range"])
	$H/V2/UpDamageTypeText.text = str(GameData.tower_data[upgraded_type]["dmgtype"])
	
func _process(delta):
	if($H/PackButton.is_hovered()):
		for i in $H/VArrows.get_children():
			i.visible = true
		for i in $H/V2.get_children():
			i.visible = true
			i.modulate = Color(0.455, 1, 0.161)
	else:
		for i in $H/VArrows.get_children():
			i.visible = false
		for i in $H/V2.get_children():
			i.visible = false
			
	
func _on_pack_button_pressed():
	get_parent().on_upgrade_pressed()
	


func _on_sell_button_pressed():
	get_parent().on_sell_pressed()
