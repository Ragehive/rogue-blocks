extends TextureProgress

onready var level_label = $MarginContainer/Label
onready var tween = $Tween

func _ready():
	update_display()
	Global.connect('update_display', self, "update_display")
	Global.connect("enemy_kill", self, "update_progress")
	pass


func update_display():
	min_value = Global.score
	max_value = Global.next_score
	level_label.text = str(Global.level)
	pass

func update_progress():
	value = Global.score
#	tween.interpolate_property(self, "value", value, Global.score, 0.1,Tween.TRANS_ELASTIC, Tween.EASE_IN)
#	tween.start()
	pass
