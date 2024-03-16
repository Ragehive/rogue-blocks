extends KinematicBody2D

#BOOLEANS
var is_active = true
var release = false

# MOVeMENT 
var offset = Vector2(0, -100)
var move_lerp = 10
var last_pos = Vector2.ZERO
var kickback_rate = 10
const MAX_KICKBACK = 20

#SHAKE
var trauma = 0.1  # Current shake strength.
var trauma_power = 3 # Trauma exponent. Use [2, 3].
export var max_offset = Vector2(0, 50)
export var decay = 1.4

#HEALTH 
var health = 1
const MAX_HEALTH = 10

#NODES 
onready var body = $Body
onready var bullet_scene = preload("res://Scenes/Components/bullet/Bullet.tscn")
onready var tween = $Tween

#TIMERS
onready var shootTimer = $Timers/ShootTimer

func _ready():
	intro_animation()
	pass

func intro_animation():
	body.position.y = 1500
	tween.start()
	tween.interpolate_property(body, "position:y", body.position.y, 0, 1, Tween.TRANS_EXPO,Tween.EASE_OUT)
	pass

func _physics_process(delta):
	if is_active:
		shake(delta)
		movement(delta)
	pass

func _trauma():
	var amount = pow(trauma, trauma_power)
	body.position.y = max_offset.y * amount * rand_range(-0.5, 0.5)

func shake(delta):
	if trauma:
		if release: trauma = max(trauma - decay * delta, 0)
		_trauma()
	pass

func movement(delta):
	if Input.is_action_pressed("move"):
#		kickback_vel.y = clamp(kickback_vel.y + kickback_rate * delta, 0, MAX_KICKBACK)
		global_position = lerp(global_position, get_global_mouse_position() + offset, move_lerp * delta)
		pass
	
	if Input.is_action_just_pressed("move"):
		shootTimer.start()
		shoot_bullet()
		release = false
#		kickback_vel.y = 0
		trauma = 0.2
	else:
		if release: global_position = lerp(global_position, last_pos, (move_lerp - 1) * delta)
			

	if Input.is_action_just_released("move"):
		shootTimer.stop()
		last_pos = get_global_mouse_position() + offset
		release = true

	pass

func shoot_bullet():
	var bullet = bullet_scene.instance()
	bullet.global_position = global_position + Vector2(0,-50)
	get_parent().add_child(bullet)
	pass

func _on_ShootRate_timeout():
	shoot_bullet()
	pass # Replace with function body.
