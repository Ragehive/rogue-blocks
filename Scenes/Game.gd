extends Node2D

onready var player_scene = preload("res://Scenes/player/Player.tscn")
onready var level_up_menu = $GUI/BottomBar/LevelUpMenu
onready var bottom_notif = $GUI/BottomNotification

func _ready():
	start()
	pass

func start():
	instance_player()
	add_notifications()
	pass

func add_notifications():
	bottom_notif.start()
	pass

func instance_player():
	var pos = get_viewport_rect().size
	var player = player_scene.instance()
	player.position = Vector2(pos.x/2, pos.y - (pos.y/4))
	add_child(player)
	pass


func game_end():
	Global.save_data()


func _on_Button_pressed():
	get_tree().paused=true
	$GUI/TopBar/CenterContainer/AnimationPlayer.play("pause")


func _on_PlayButton_pressed():
	get_tree().paused=false
	$GUI/TopBar/CenterContainer/AnimationPlayer.play_backwards("pause")
