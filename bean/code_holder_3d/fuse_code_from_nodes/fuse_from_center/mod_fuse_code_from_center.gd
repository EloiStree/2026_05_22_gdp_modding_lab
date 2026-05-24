class_name ModFuseCodeFromCenter
extends Node


signal on_code_fused(code_as_string:String)
signal on_code_fused_array(code_as_string_array:Array[String])

@export var anchor_point:Node3D
@export var nodes_to_search_in:Array[Node]
@export var with_recusivity:bool =true
@export var get_code_method_name:String="get_code"
@export var split:="\n"

@export var load_at_ready:bool = true
@export var nodes_found_with_method:Array[Node]
@export var code_as_string_array:Array[String]
@export_multiline() var code_as_text:String

func _ready() -> void:
	if load_at_ready:
		fuse_code_from_nodes_in_inspector()

func set_nodes_to_search_in(nodes:Array[Node]):
	nodes_to_search_in = nodes
	
	
func fuse_code_from_nodes_in_inspector() -> void:
	if with_recusivity:
		nodes_found_with_method = ModSearchForCodeInArray.get_all_childrens_recursively_having_code_method_from_array(nodes_to_search_in)
	else:
		nodes_found_with_method = ModSearchForCodeInArray.get_all_nodes_no_recursively_having_code_method_from_array(nodes_to_search_in)

	code_as_string_array = ModSearchForCodeInArray.generate_code_from_nodes_from_center(
		nodes_found_with_method,
		anchor_point,
		get_code_method_name
	)
	code_as_text = split.join(code_as_string_array)
	on_code_fused.emit(code_as_text)
	on_code_fused_array.emit(code_as_string_array)
