extends Node


@export var node_to_affect: Node

@export_group("Name of the method to call")
@export var method_turn_on_light:String ="turn_on_light"
@export var method_turn_off_light:String ="turn_off_light"
@export var method_set_light_state:String ="set_light_state"
@export var method_set_color:String ="set_color"


func turn_on_light():
	if node_to_affect.has_method(method_turn_on_light):
		node_to_affect.call(method_turn_on_light)

func turn_off_light():
	if node_to_affect.has_method(method_turn_off_light):
		node_to_affect.call(method_turn_off_light)
		
func set_light_state(is_on:bool):
	if node_to_affect.has_method(method_set_light_state):
		node_to_affect.call(method_set_light_state, is_on)
	
func set_random_color():
	set_color(Color( randf() , randf() , randf() ) )

func set_color(color:Color):
	node_to_affect.call(method_set_color,  color)
