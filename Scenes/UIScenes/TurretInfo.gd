extends ColorRect

var type
# Called when the node enters the scene tree for the first time.
func _ready():
	type = get_parent().name
	print(type)
	$H/TurretTexture.texture = get_parent().get_node("Turret").texture
	$TextureRect/TowerName.text = type
	$H/V/DamageText.text = str(GameData.tower_data[type]["damage"])
	$H/V/FireRateText.text = str(GameData.tower_data[type]["rof"])
	$H/V/RangeText.text = str(GameData.tower_data[type]["range"])
	$H/V/DamageTypeText.text = str(GameData.tower_data[type]["dmgtype"])
