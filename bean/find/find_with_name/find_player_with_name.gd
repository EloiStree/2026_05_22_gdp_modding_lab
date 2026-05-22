extends Node

@onready var player_node: Node = get_tree().root.find_child("Player", true, false)
@export var player_node_found:Node3D

func _ready() -> void:
	player_node_found = player_node
	while true:
		if player_node:
			player_node.show()
			await get_tree().create_timer(1).timeout
			player_node.hide()
			await get_tree().create_timer(1).timeout
		else: 
			await get_tree().create_timer(0.1).timeout
