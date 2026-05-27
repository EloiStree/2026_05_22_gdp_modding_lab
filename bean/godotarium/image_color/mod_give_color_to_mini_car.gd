class_name ModGiveColorToMiniCar
extends Node

@export var ground_image_source: ModImagePixelColorBasic

@export var mini_cars_parent_node: Node3D

@export var mini_cars:Array[ModMiniCarFromJoystickCharacter]

@export var quad_left_down:Node3D
@export var quad_right_up:Node3D
@export var quad_width:float
@export var quad_height:float

@export var top_right_relcoated:Vector3


func _ready():
	refresh_mini_cars_array()

func _process(delta: float) -> void:
	
	top_right_relcoated = relocate_point(quad_left_down, quad_right_up.global_transform.origin)
	quad_width = top_right_relcoated.x
	quad_height = top_right_relcoated.z

	for car in mini_cars:
		if not car:
			continue
		var left_point = car.get_left_line_tracker_global_position()
		var left_point_relocated=  relocate_point(quad_left_down, left_point)
		var left_point_percent = Vector2(left_point_relocated.x, left_point_relocated.z) / Vector2(quad_width, quad_height)
		var color = ground_image_source.get_pixel_color_from_lrdt_percent(left_point_percent.x,left_point_percent.y)
		car.set_by_developer_left_line_color(color)

		var right_point = car.get_right_line_tracker_global_position()
		var right_point_relocated=  relocate_point(quad_left_down, right_point)
		var right_point_percent = Vector2(right_point_relocated.x, right_point_relocated.z) / Vector2(quad_width, quad_height)
		color = ground_image_source.get_pixel_color_from_lrdt_percent(right_point_percent.x ,right_point_percent.y)
		car.set_by_developer_right_line_color(color)



func relocate_point( cartesian:Node3D, point:Vector3)->Vector3:
	var cartesian_position:Vector3 = cartesian.global_transform.origin
	var cartesian_quaternion:Quaternion = cartesian.global_transform.basis.get_rotation_quaternion()
	var relocated_point:Vector3 = point - cartesian_position
	var rotated_point:Vector3 = cartesian_quaternion * relocated_point
	rotated_point.z = -rotated_point.z
	return rotated_point


func refresh_mini_cars_array():
	mini_cars.clear()
	for child in mini_cars_parent_node.get_children():
		if child is ModMiniCarFromJoystickCharacter:
			mini_cars.append(child)
