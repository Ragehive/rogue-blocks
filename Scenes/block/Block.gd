extends StaticBody2D

#VARIABLES
var health = 2
var max_health = 2
var speed = 90

#SHAKE
var trauma = 0.1  # Current shake strength.
var trauma_power = 3 # Trauma exponent. Use [2, 3].
export var max_offset = Vector2(0, 50)
export var decay = 1.4

#NODES
onready var body = $Body
onready var label = $Body/Label
onready var block_particle_scene = preload("res://Scenes/Components/particles/BlockParticle/BlockParticle.tscn")
onready var blinkAnim = $BlinkAnimationPlayer
onready var hitSound = $HitSound

var is_pause = false

func _ready():
	Global.connect("pause", self, "pause")
	start()
	pass

func start():
	health = round(rand_range(1, health))
	max_health = health
	label.text = str(health)
	pass

func _process(delta):
	shake(delta)

func _physics_process(delta):
	if is_pause == false:
		move_local_y(speed * delta)
	pass

func _trauma():
	var amount = pow(trauma, trauma_power)
	body.position.y = max_offset.y * amount * rand_range(-0.5, 0.5)

func add_trauma(amount):
	trauma = amount
	pass

func update_healh_label():
	label.text = str(health)
	pass

#func add_label_particle(damage):
#	var object = label_particle_scene.instance()
#	object.global_position = global_position + Vector2(70,-50)
#	object.get_node("Body/Label").text = "-" + str(damage)
#	get_parent().add_child(object)
#	pass

func add_block_particle():
	var scene = block_particle_scene.instance()
	scene.global_position = global_position
	get_parent().add_child(scene)
	
	pass

func shake(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		_trauma()
	pass

func check_level_up():
	if Global.score >= Global.next_score:
		Global.emit_signal("level_up")
	else:
		Global.emit_signal("enemy_kill")
	pass

func take_damage(damage):
	health = max(health - damage, 0)
	update_healh_label()
	add_trauma(0.8)
	
	if health <= 0:
		add_block_particle()
		queue_free()
		Global.score += max_health
		check_level_up()
	else:
		hitSound.play()
#	add_label_particle(damage)
	pass

func pause():
	is_pause = true
