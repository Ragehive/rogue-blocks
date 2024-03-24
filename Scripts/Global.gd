extends Node


const FILEPATH = "user://GAMEDATA.save"
var score = 0
var highscore = 0
var coin = 0
var level = 1
var sound_turned_off = false
var music_turned_off = false

func _ready():
#	load_data()
	pass

func save():
	var data = {
		"Highscore": highscore,
		"Score": score,
		"Coin": coin,
		"Level": level,
		"Sound": sound_turned_off,
		"music": music_turned_off
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
		score = data["Score"]
		level = data["Level"]
		sound_turned_off = data["Sound"]
		music_turned_off = data["Music"]
		save_data.close()
	pass
	
