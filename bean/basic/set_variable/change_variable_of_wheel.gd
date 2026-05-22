extends Node


@export var node_to_affect:Node
@export var variable_name_to_change:String = ""

func set_speed(speed_in_meter_per_seconds:float):
	if has_property(node_to_affect,variable_name_to_change) :
		node_to_affect.set(variable_name_to_change,speed_in_meter_per_seconds)

func has_property(node: Node, property_name: String) -> bool:
	for prop in node.get_property_list():
		if prop.name == property_name:
			return true
	return false
