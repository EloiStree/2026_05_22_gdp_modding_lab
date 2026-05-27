class_name ModMiniCarFromJoystickCharacter
extends CharacterBody3D

@export var move_speed_in_ms: float = 0.2
@export var rotation_speed_angle: float = 90
@export var gravity: float = 0.2 

@export var joystick: Vector2 = Vector2.ZERO
@export var forward_rayscast_distance:float
@export var left_line_sensor_color:Color
@export var right_line_sensor_color:Color
@export var global_euler_for_debug:Vector3
@export var global_position_for_debug:Vector3

## Expect a joystick from -1 to 1 in X Yup
func set_joystick(joystick_value: Vector2) -> void:
	joystick_value.x = clamp(joystick_value.x, -1, 1)
	joystick_value.y = clamp(joystick_value.y, -1, 1)
	self.joystick = joystick_value    

func _physics_process(delta: float) -> void:
	
	global_position_for_debug = car_ground_wheel_center_point.global_position
	global_euler_for_debug = car_ground_wheel_center_point.global_rotation_degrees
	
	## On tourne sur le Y du character avec le temps qui passe par frame (delta)
	# Attention le rotation sont en radian et pas en degrees.
	if abs(joystick.x) > 0.1: 
		rotate_y(-joystick.x * deg_to_rad(rotation_speed_angle)     * delta)

	# Le Z de godot est inverse du Z de Unity que l on utilise nous.
	var forward_direction = -global_transform.basis.z      
	## On utilise la vitesse et le joystick pour donner la direction
	var target_velocity = forward_direction * (joystick.y) * move_speed_in_ms    
	## On donne les informations a velocity pour bouger le character
	velocity.x = target_velocity.x
	velocity.z = target_velocity.z    
	velocity.y = -gravity

	## on demande au code d être calculer.
	move_and_slide()


func get_forward_distance()->float:
	return forward_rayscast_distance

func get_left_line_color()->Color:
	return left_line_sensor_color

func get_right_line_color()->Color:
	return right_line_sensor_color



#region COMPLEXITY

@export var car_ground_wheel_center_point:Node3D
@export var car_forward_point:Node3D
@export var car_right_side_point:Node3D
@export var car_left_line_tracker:Node3D
@export var car_right_line_tracker:Node3D


func set_by_developer_distance_rayscast(distance:float):
	forward_rayscast_distance = distance

func set_by_developer_left_line_color(color:Color):
	left_line_sensor_color = color

func set_by_developer_right_line_color(color:Color):
	right_line_sensor_color = color

func get_left_line_tracker_global_position()->Vector3:
	return car_left_line_tracker.global_position if car_left_line_tracker else Vector3.ZERO
	
func get_right_line_tracker_global_position()->Vector3:
	return car_right_line_tracker.global_position if car_right_line_tracker else Vector3.ZERO

func get_global_position()->Vector3:
	return car_ground_wheel_center_point.global_position if car_ground_wheel_center_point else Vector3.ZERO

func get_global_euler_radian()->Vector3:
	return car_ground_wheel_center_point.global_rotation if car_ground_wheel_center_point else Vector3.ZERO

func get_global_euler_euler()->Vector3:
	return car_ground_wheel_center_point.global_rotation_degrees if car_ground_wheel_center_point else Vector3.ZERO

func get_global_quaternion()->Quaternion:
	return Quaternion.from_euler(car_ground_wheel_center_point.global_rotation) if car_ground_wheel_center_point else Quaternion.IDENTITY

func get_global_unity_forward_direction()->Vector3:
	return -car_ground_wheel_center_point.global_basis.z if car_ground_wheel_center_point else Vector3.ZERO
	
#endregion
