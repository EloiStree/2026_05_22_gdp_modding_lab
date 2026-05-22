extends Node

@export var player_group_name := "player"
@export var node_found_in_group: Node3D

func _ready() -> void:
	node_found_in_group = get_tree().get_first_node_in_group(player_group_name) as Node3D
	while true:
		if node_found_in_group:
			node_found_in_group.show()
			await get_tree().create_timer(1).timeout
			node_found_in_group.hide()
			await get_tree().create_timer(1).timeout
		else:
			await get_tree().create_timer(1).timeout
		
	
