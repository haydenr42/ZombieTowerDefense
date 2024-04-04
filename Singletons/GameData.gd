extends Node

var tower_data = {
	"GunI": {
		"damage" : 20,
		"rof" : 1,
		"range" : 350,
		"category" : "Projectile",
		"cost" : 50},
	"MissileI": {
		"damage" : 100,
		"rof" : 3,
		"range": 550,
		"category": "Missile",
		"cost" : 75},
	"FlamethrowerI": {
		"damage" : 0.5,
		"range" : 200,
		"rof" : 0,
		"category" : "Fire",
		"cost" : 20},
	"MortarI": {
		"damage" : 35,
		"range": 450,
		"rof" : 4,
		"category" : "Artillery",
		"cost" : 30}
	}
	
var enemy_data = {
	"Zombie": {
		"hp" : 100,
		"type" : "Organic",
		"reward" : 25,
		"speed": 50,
		"penalty" : 10},
	"BlueTank": {
		"hp" : 150,
		"type" : "Machine",
		"reward" : 50,
		"speed" : 90,
		"penalty": 20},
	"HellHound": {
		"hp" : 75,
		"type" : "Organic",
		"reward": 5,
		"speed": 50,
		"penalty": 5}
}

var wave_data = {
	"Map1": {
		"wave_count": 4,
		"wave1" : [["HellHound",1],["Zombie",1],["HellHound",1],["Zombie",1]],
		"wave2" : [["Zombie",2],["Zombie",2],["BlueTank",6],["BlueTank",1],["Zombie",2]],
		"wave3" : [["BlueTank",2],["BlueTank",2],["Zombie",6],["Zombie",1],["Zombie",2],["BlueTank",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2]],
		"wave4" : [["Zombie",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2],["Zombie",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2]]},
	"Map2": {
		"wave_count": 4,
		"wave1" : [["HellHound",2],["Zombie",2],["HellHound",2],["Zombie",2]],
		"wave2" : [["Zombie",2],["Zombie",2],["BlueTank",6],["BlueTank",1],["Zombie",2]],
		"wave3" : [["BlueTank",2],["BlueTank",2],["Zombie",6],["Zombie",1],["Zombie",2],["BlueTank",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2]],
		"wave4" : [["Zombie",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2],["Zombie",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2]]}
}

	
