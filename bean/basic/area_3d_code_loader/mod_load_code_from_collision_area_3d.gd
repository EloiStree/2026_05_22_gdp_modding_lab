class_name  ModLoadCodeFromCollisionArea3D
extends Node

signal on_code_found(code_as_text:String)
@export var area_observed:Area3D
@export var get_code_method_name="get_code"
@export var unload_on_exit:bool=false
@export var last_code_found:String=""

@export var listen_to_area:bool= true
@export var listen_to_body:bool= true

@export var use_debug_print:bool

func _ready() -> void:
	if area_observed:
		area_observed.area_entered.connect(_enter_area)
		area_observed.area_exited.connect(_exit_area)
		area_observed.body_entered.connect(_enter_body)
		area_observed.body_exited.connect(_exit_body)
	else :
		push_warning("Area is empty")
	if use_debug_print:
		on_code_found.connect(
			func(text):
				print("Code:", text)
		)

func _enter_area(area:Area3D):
	if listen_to_area:
		get_and_emit_code_from(area)		

func _exit_area(area:Area3D):
	if listen_to_area:
		if unload_on_exit:
			remove_code_if_had_code(area)

func _enter_body(area:Node3D):
	if listen_to_body:
		get_and_emit_code_from(area)
	
func _exit_body(area:Node3D):
	if listen_to_body:
		if unload_on_exit:
			remove_code_if_had_code(area)


func get_and_emit_code_from(node:Node3D):
	if node==null: return
	var nodes:Array[Node] = search_recursively_for_node_with_get_code(node)
	var code:String =""
	for n in nodes:
		code+=n.call(get_code_method_name)
	last_code_found= code
	on_code_found.emit(code)

	
	
	
	
func remove_code_if_had_code(node:Node3D):
	if not remove_code_if_had_code:
		return 
	var nodes:Array[Node] = search_recursively_for_node_with_get_code(node)
	if nodes and nodes.size()>0:
		last_code_found=""
		on_code_found.emit("")
		
		
	
	
	
func search_recursively_for_node_with_get_code(node:Node3D):
	var node_with_code:Array[Node]= get_all_childrens_recursively_having_code_method_from_array(
		[node],
		get_code_method_name
	)
	return node_with_code
	

static func get_all_childrens_recursively_having_code_method_from_array(nodes:Array[Node], get_code_method_name:String="get_code") -> Array[Node]:
	var result:Array[Node] = []
	for n in nodes:
		if n.has_method(get_code_method_name):
			result.append(n)
		for child in n.get_children():
			var local_nodes : Array[Node]= get_all_childrens_recursively_having_code_method_from_array([child], get_code_method_name)
			result.append_array(local_nodes)
	return result
