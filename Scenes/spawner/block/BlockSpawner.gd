extends Node2D

onready var block_scene = preload("res://Scenes/block/Block.tscn")
onready var positions = $positions
onready var spawn_timer = $SpawnTimer
onready var diff_timer = $DifficulyTimer

onready var block_amount = 2
var positionArr = []

var health_diff = 0

func _ready():
	randomize()
	set_positions()
	for i in positions.get_children():
		positionArr.append(i.global_position)
	
	start()
	pass

func start():
	spawn_timer.start()
	diff_timer.start()
	spawn_blocks(rand_range(0,4))
	pass

func set_positions():
	var spacing = 160
	var base_pos = (get_viewport_rect().size.x / 2) - ( spacing * 2 )
	for i in positions.get_child_count():
		var positioner = positions.get_child(i);
		positioner.global_position = Vector2(base_pos + (spacing * i ) + spacing/2, -80)
		positioner.global_position.x


func spawn_blocks(block_amt):
	var arr = positionArr.duplicate()
	var blocks = positions.get_child_count() - block_amt
	for i in range(blocks, positions.get_child_count()):
		var get_index = randi()%arr.size()
		var pos = arr[get_index]
		
		var block = block_scene.instance()
		block.position = pos
		block.health = block.health + health_diff
		add_child(block)
		arr.remove(get_index)
	pass


func _on_SpawnTimer_timeout():
	randomize()
	spawn_blocks(rand_range(0,4))
	pass # Replace with function body.


func _on_DifficulyTimer_timeout():
	health_diff += 2
	pass # Replace with function body.
