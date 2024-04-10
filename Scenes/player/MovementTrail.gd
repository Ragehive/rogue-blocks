extends Line2D

export (NodePath) var player_path
export var length = 10
onready var player = get_node(player_path)

func _process(delta):
	if !player: return
	global_position = Vector2.ZERO
	global_rotation = 0
	
	add_point(player.global_position - player.offset)
	while(get_point_count() > length):
		remove_point(0)
	
	pass
