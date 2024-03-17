extends Node

var score = 0
var next_score = 10
var high_score = 0
var level = 1
var next_level = 2

var is_levelling_up = false

signal level_up
signal update_display
signal level_up_player(level_up_type)

#LEVEL UP OPTIONS
const level_up = {
	"INCREASE_BULLET_DAMAGE": {
		"damage": 0.85,
		"speed": 0.0,
		"critical_damage": 0.0
	},
	"INCREASE_BULLET_SPEED": {
		"damage": 0.0,
		"speed": 0.0,
		"critical_damage": 0.0
	},
	"INCREASE_CRITICAL_DAMAGE": {
		"damage": 0.0,
		"speed": 0.0,
		"critical_damage": 1.0
	},
}

#UPGRADES
const upgrades = {
	"damage": 0.0,
	"speed": 0.0,
	"critical_damage": 0.0
}

func _ready():
	reset_upgrades()
	pass

func reset_upgrades():
	for i in upgrades: upgrades[i] = 0

func insert_upgrades(text):
	var upgrade = level_up[text]
	upgrades.damage += upgrade.damage
	upgrades.speed += upgrade.speed
	upgrades.critical_damage += upgrades.critical_damage
	print("uprgades", upgrades)
