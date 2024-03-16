extends StaticBody2D

#VARIABLES
var health = 2
var max_health = 2
var speed = 100

#SHAKE
var trauma = 0.1  # Current shake strength.
var trauma_power = 3 # Trauma exponent. Use [2, 3].
export var max_offset = Vector2(0, 50)
export var decay = 1.4

#NODES
onready var body = $Body
onready var label = $Body/Label
onready var label_particle_scene = preload("res://Scenes/Components/LabelParticle/LabelParticle.tscn")

func _ready():
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

func add_label_particle(damage):
	var object = label_particle_scene.instance()
	object.global_position = global_position + Vector2(70,-50)
	object.get_node("Body/Label").text = "-" + str(damage)
	get_parent().add_child(object)
	pass

func shake(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		_trauma()
	pass

func take_damage(damage):
	health = max(health - damage, 0)
	update_healh_label()
	add_trauma(0.8)
	if health <= 0:
		queue_free()
		Global.score += max_health
#	add_label_particle(damage)
	pass
