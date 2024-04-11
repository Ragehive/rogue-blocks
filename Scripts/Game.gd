extends Node2D

signal countdown_finished
onready var player_scene = preload("res://Scenes/player/Player.tscn")
onready var level_up_menu = $GUI/BottomBar/LevelUpMenu
onready var sprite = $GUI/BottomBar2/Sprite/AnimationPlayer
var countdown_duration = 4
var countdown_timer = 4
var is_pause = false

func _ready():
	Global.connect("pause", self, "pause")
	instance_player()
	$GUI/GameOver/GameO.hide()

func _process(delta):
	
	if is_pause == true:
		countdown_timer -= delta
		if countdown_timer <= 0:
			countdown_timer = 0
			update_label()
			emit_signal("countdown_finished")
		else:
			update_label()

func instance_player():
	var pos = get_viewport_rect().size
	var player = player_scene.instance()
	player.position = Vector2(pos.x/2, pos.y - (pos.y/4))
	add_child(player)
	pass


func game_end():
	Global.save_data()


func _on_DangerArea_area_entered(area):
	if area.is_in_group("enemy"):
		sprite.play("color_blink")


func _on_DeathArea_area_entered(area):
	if area.is_in_group("enemy"):
		Global.emit_signal("pause")
		$GUI/GameOver/GameO.show()
		Global.emit_signal("pause")
		start_countdown()
		

func start_countdown():
	countdown_timer = countdown_duration
	update_label()

func update_label():
	$GUI/GameOver/GameO/Label2.text = str(int(countdown_timer))



func _on_TouchScreenButton_pressed():
	get_tree().reload_current_scene()


func _on_ContinueToGameOver_pressed():
	Global.emit_signal("pause")
	$GUI/GameOver/MainGameO.visible = true
	$GUI/GameOver/GameO.visible = false
	$GUI/TopBar.visible = false
	$GUI/BottomBar.visible = false
	$GUI/BottomBar2.visible = false


func _on_ContinueToWatchAd_pressed():
	pass # Replace with function body.


func _on_Game_countdown_finished():
	if countdown_timer == 0:
		Global.emit_signal("pause")
		$GUI/GameOver/MainGameO.visible = true
		$GUI/GameOver/GameO.visible = false
		$GUI/TopBar.visible = false
		$GUI/BottomBar.visible = false
		$GUI/BottomBar2.visible = false

func pause():
	is_pause = true
