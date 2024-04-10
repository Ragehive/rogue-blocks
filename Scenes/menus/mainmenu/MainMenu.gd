extends CanvasLayer

var play_activated = false
var DRAG_SPEED = 50
onready var game_scene = preload("res://Scenes/Game.tscn")
onready var anim = $AnimationPlayer
onready var tween = $Tween
onready var title = $Control/Title
onready var bottom = $Control/Bottom

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.001),"timeout")
	ease_in_animation()
	pass # Replace with function body.

func _input(event):
	if event is InputEventScreenDrag:
		if abs(event.speed.x) > DRAG_SPEED and !play_activated:
			play_activated = true
			play_game()
	pass

func play_game():
	var game = game_scene.instance()
	get_parent().add_child(game)
	anim.play("outro")
	ease_out_animation()
#	get_tree().change_scene("res://Scenes/Game.tscn")
	pass

func ease_in_animation():
	var curr_title_pos = title.rect_global_position.y
	var curr_bottom_pos = bottom.rect_global_position.y
	var next_title_pos = curr_title_pos - 600
	var next_bottom_pos = curr_bottom_pos + 700
	title.rect_global_position.y = next_title_pos
	bottom.rect_global_position.y = next_bottom_pos

	tween.start()
	tween.interpolate_property(title, "rect_global_position:y", next_title_pos, curr_title_pos, 0.3,Tween.TRANS_CIRC,Tween.EASE_OUT)
	tween.interpolate_property(bottom, "rect_global_position:y", next_bottom_pos, curr_bottom_pos, 0.3,Tween.TRANS_CIRC, Tween.EASE_OUT)
	pass

func ease_out_animation():
	var curr_title_pos = title.rect_global_position.y
	var curr_bottom_pos = bottom.rect_global_position.y
	var next_title_pos = curr_title_pos - 600
	var next_bottom_pos = curr_bottom_pos + 700
	tween.start()
	tween.interpolate_property(title, "rect_global_position:y", curr_title_pos, next_title_pos, 0.6,Tween.TRANS_CIRC,Tween.EASE_IN)
	tween.interpolate_property(bottom, "rect_global_position:y", curr_bottom_pos, next_bottom_pos, 0.6,Tween.TRANS_CIRC, Tween.EASE_IN)
	
	yield(tween, "tween_all_completed")
	queue_free()
	pass

func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
	pass # Replace with function body.

func _on_Settings_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()

func _on_Store_pressed():
	pass # Replace with function body.

func _on_Leaderboard_pressed():
	pass # Replace with function body.
