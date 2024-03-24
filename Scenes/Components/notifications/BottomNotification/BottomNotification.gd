extends Control
onready var anim = $AnimationPlayer

func _ready():
	pass

func start():
	anim.play("fade-out")
	pass
