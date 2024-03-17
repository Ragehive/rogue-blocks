extends Node


const FILEPATH = "user://GAMEDATA.save"
var score = 0
var next_score = 10
var highscore = 0
var level = 1
var next_level = 2
var coin = 0
var sound_turned_off = false
var music_turned_off = false

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
	load_data()
	pass

func reset_upgrades():
	for i in upgrades: upgrades[i] = 0

func insert_upgrades(text):
	var upgrade = level_up[text]
	upgrades.damage += upgrade.damage
	upgrades.speed += upgrade.speed
	upgrades.critical_damage += upgrades.critical_damage
	print("uprgades", upgrades)

func save():
	var data = {
		"Highscore": highscore,
		"Coin": coin,
		"Level": level,
		"Sound": sound_turned_off,
		"Music": music_turned_off
	}
	return data


func save_data():
	
	var file = File.new()
	file.open_encrypted_with_pass(FILEPATH, File.WRITE, "RageHive")
	file.store_var(save())
	file.close()

func load_data():
	var save_data = File.new()
	if save_data.file_exists(FILEPATH):
		save_data.open_encrypted_with_pass(FILEPATH, File.READ, "RageHive")
		var data = save_data.get_var()
		coin = data["Coin"]
		highscore = data["Highscore"]
		level = data["Level"]
		sound_turned_off = data["Sound"]
		music_turned_off = data["Music"]
		save_data.close()
	print(highscore, 'highscore')
	pass
	
