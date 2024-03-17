extends Node2D

onready var player_scene = preload("res://Scenes/player/Player.tscn")

func _ready():
	instance_player()
	pass


func instance_player():
	var pos = get_viewport_rect().size
	var player = player_scene.instance()
	player.position = Vector2(pos.x/2, pos.y - (pos.y/4))
	add_child(player)
	
	
	pass


func game_end():
	Global.save_data()
