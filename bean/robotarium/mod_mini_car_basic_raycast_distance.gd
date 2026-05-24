class_name ModMiniCarBasicRaycastDistance
extends Node
signal on_raycast_hit_distance_updated(distance: float)
@export var raycast: RayCast3D
@export var last_distance_in_meter: float = -1.0
func _process(delta: float) -> void:
	if raycast == null:
		return
	if raycast.is_colliding():
		var collision_point: Vector3 = raycast.get_collision_point()
		var distance: float = raycast.global_position.distance_to(collision_point)
		last_distance_in_meter = distance
		on_raycast_hit_distance_updated.emit(distance)
	else :
		last_distance_in_meter=0
		on_raycast_hit_distance_updated.emit(0)
