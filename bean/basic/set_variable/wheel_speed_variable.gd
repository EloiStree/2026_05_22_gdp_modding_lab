extends Node


@export var node_to_rotate:Node3D
@export var wheel_speed_x :float = 180

func _process(delta: float) -> void:
	node_to_rotate.rotate_x(wheel_speed_x*delta)
