extends Node2D

onready var tween = $Tween

var offset = 500
var can_press = false

onready var delayTimer = $DelayTimer
onready var panel_label_1 = $HBoxContainer/Panel/Label
onready var panel_label_2 = $HBoxContainer/Panel2/Label
onready var panel_label_3 = $HBoxContainer/Panel3/Label

func _ready():
	Global.connect("level_up", self, "level_up")
	pass

func level_up():
	delayTimer.start()
	pass

func start():
	can_press = true
	tween.start()
	tween.interpolate_property(self, "global_position:y", global_position.y, global_position.y - offset, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	
	get_tree().paused = true
	pass

func end(text):
	can_press = false
	tween.start()
	tween.interpolate_property(self, "global_position:y", global_position.y, global_position.y + offset, 0.5, Tween.TRANS_EXPO, Tween.EASE_IN)
	
	yield(tween, "tween_completed")
	get_tree().paused = false
	can_press = true
	level_up_score()
	Global.emit_signal("update_display")
	Global.insert_upgrades(convert_text_to_enum(text))
	Global.emit_signal("level_up_player", convert_text_to_enum(text))
	pass

func level_up_score():
	var score = Global.next_score
	Global.next_score = Global.score + round(score * 0.8)
	Global.level += 1
	Global.next_level += 1
	pass

func convert_text_to_enum(_text):
	return _text.capitalize().replace(" ", "_").to_upper()
	pass

func _on_Panel_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		end(panel_label_1.text)
	pass # Replace with function body.


func _on_Panel2_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		end(panel_label_2.text)
	pass # Replace with function body.


func _on_Panel3_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		end(panel_label_3.text)
	pass # Replace with function body.


func _on_DelayTimer_timeout():
	start()
	pass # Replace with function body.
