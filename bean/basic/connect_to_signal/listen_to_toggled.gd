extends Node

@export var node_to_listen_to:Node
@export var signal_name_toggle="toggled"


@export_group("Debug")
@export var is_node_toggled:bool =false
func _ready() -> void:
	if node_to_listen_to and node_to_listen_to.has_signal(signal_name_toggle):
		node_to_listen_to.connect(signal_name_toggle,_on_toggled_value_changed)
	
func _on_toggled_value_changed(is_toggled:bool):
	print("Toggled detected:",is_toggled)
	is_node_toggled =is_toggled
	
