extends Node

var tower_data = {
	"GunI": {
		"damage" : 20,
		"rof" : 0.8,
		"range" : 350,
		"dmgtype" : "Physical",
		"cost" : 50},
	"MissileI": {
		"damage" : 100,
		"rof" : 3,
		"range": 550,
		"dmgtype": "Physical",
		"cost" : 75},
	"FlamethrowerI": {
		"damage" : 0.5,
		"range" : 200,
		"rof" : 0,
		"dmgtype" : "Fire",
		"cost" : 20},
	"MortarI": {
		"damage" : 35,
		"range": 550,
		"rof" : 3.5,
		"dmgtype" : "Physical",
		"cost" : 30},
	"CrossBowI": {
		"damage" : 50,
		"range": 450,
		"rof" : 2.5,
		"dmgtype" : "Physical",
		"cost" : 25},
	"GunII": {
		"damage" : 30,
		"rof" : 0.5,
		"range" : 400,
		"dmgtype" : "Physical",
		"cost" : 50},
	"MissileII": {
		"damage" : 100,
		"rof" : 3,
		"range": 550,
		"dmgtype": "Physical",
		"cost" : 75},
	"FlamethrowerII": {
		"damage" : 0.7,
		"range" : 250,
		"rof" : 0,
		"dmgtype" : "Fire",
		"cost" : 20},
	"MortarII": {
		"damage" : 50,
		"range": 650,
		"rof" : 3.5,
		"dmgtype" : "Physical",
		"cost" : 30},
	"CrossBowII": {
		"damage" : 75,
		"range": 450,
		"rof" : 2,
		"dmgtype" : "Physical",
		"cost" : 25}
	}
	
var enemy_data = {
	"Zombie": {
		"hp" : 100,
		"type" : "Organic",
		"reward" : 2,
		"speed": 75,
		"penalty" : 10},
	"HazmatZombie": {
		"hp" : 200,
		"type" : "Organic",
		"reward" : 5,
		"speed": 60,
		"penalty" : 10},
	"BlueTank": {
		"hp" : 150,
		"type" : "Machine",
		"reward" : 5,
		"speed" : 90,
		"penalty": 20},
	"HellHound": {
		"hp" : 75,
		"type" : "Organic",
		"reward": 1,
		"speed": 100,
		"penalty": 5}
}

var wave_data = {
	"Map1": {
		"wave_count": 4,
		"wave1" : [["HazmatZombie",3],["HellHound",1],["Zombie",1],["HellHound",1],["Zombie",1]],
		"wave2" : [["Zombie",2],["Zombie",2],["BlueTank",6],["BlueTank",1],["Zombie",2],["HazmatZombie",3]],
		"wave3" : [["BlueTank",2],["BlueTank",2],["Zombie",6],["Zombie",1],["Zombie",2],["BlueTank",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2]],
		"wave4" : [["Zombie",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2],["Zombie",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2]]},
	"Map2": {
		"wave_count": 4,
		"wave1" : [["HellHound",2],["Zombie",2],["HellHound",2],["Zombie",2]],
		"wave2" : [["Zombie",2],["Zombie",2],["BlueTank",6],["BlueTank",1],["Zombie",2]],
		"wave3" : [["BlueTank",2],["BlueTank",2],["Zombie",6],["Zombie",1],["Zombie",2],["BlueTank",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2]],
		"wave4" : [["Zombie",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2],["Zombie",2],["Zombie",2],["Zombie",6],["Zombie",1],["Zombie",2]]}
}

	
