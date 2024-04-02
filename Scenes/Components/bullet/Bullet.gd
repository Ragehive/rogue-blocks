extends KinematicBody2D
var dead = false

#FEATURES
var features = {
	"damage": 1,
	"speed": 600,
	"critical_damage_rand": 10
}

#NODES
onready var hit_particle_scene = preload("res://Scenes/Components/particles/HitParticle/HitParticle.tscn")

func _ready():
	randomize()
	add_upgrades()
	print(features)
	pass

func add_upgrades():
	features.damage += int(Global.upgrades.damage)
	features.speed += int(Global.upgrades.speed)
	features.critical_damage_rand -= int(Global.upgrades.critical_damage)
	pass

func _physics_process(delta):
	var direction = Vector2(0, -features.speed)
	move_and_collide(direction * delta)

func instance_hit_particle():
	var object = hit_particle_scene.instance()
	object.global_position = global_position
	get_parent().add_child(object)
	pass

func add_damage():
	return round(features.damage + add_critical_damage())
	pass

func add_critical_damage():
	var critical_damage = 0
	var rand = randi()%features.critical_damage_rand
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
