extends KinematicBody2D

var speed = Vector2(0, -800)
var damage = 1
var critical_damage_randomness = 10
var dead = false

#NODES
onready var hit_particle_scene = preload("res://Scenes/Components/HitParticle/HitParticle.tscn")

func _ready():
	randomize()
	pass

func _physics_process(delta):
	move_and_collide(speed * delta)

func instance_hit_particle():
	var object = hit_particle_scene.instance()
	object.global_position = global_position
	get_parent().add_child(object)
	pass

func add_damage():
	return round(damage + add_critical_damage())
	pass

func add_critical_damage():
	var critical_damage = 0
	var rand = randi()%critical_damage_randomness
	if (rand == 0): critical_damage = rand_range(0, critical_damage)
	return critical_damage

func _on_Area2D_body_entered(body):
#	player.pitch_scale = 1
#	player.play()
	instance_hit_particle()
	body.take_damage(add_damage())
	queue_free()
	pass # Replace with function body.


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
	pass # Replace with function body.
