class_name ModSearchForCodeInArray
extends Node

# static func generate_code_from_nodes_from_node3d_local_direction_up_down(nodes:Array[Node], get_code_method_name:String="get_code", cartesian_anchor:Node3D) -> Array[string]:
# 	return generate_code_from_nodes_from_node3d_local_direction(nodes, get_code_method_name,cartesian_anchor,Vector3.DOWN)
# static func generate_code_from_nodes_from_node3d_local_direction_left_right(nodes:Array[Node], get_code_method_name:String="get_code", cartesian_anchor:Node3D) -> Array[string]:
# 	return generate_code_from_nodes_from_node3d_local_direction(nodes, get_code_method_name,cartesian_anchor,Vector3.RIGHT)
# static func generate_code_from_nodes_from_node3d_local_direction(nodes:Array[Node], get_code_method_name:String="get_code", cartesian_anchor:Node3D, local_direction:Node3D) -> Array[string]:
# 	for node in nodes:
# 		if node is Node3D:
# 			var global_position:Vector3 = node.global_position
# 			var local_position:Vector3 = relocated_global_to_local(node,global_position)

static func relocated_global_to_local(cartesian:Node3D, global_position : Vector3) -> Vector3:
	var to_rotate :Vector3 = global_position- cartesian.global_position
	var quaterinon :Quaternion= Quaternion.from_euler(cartesian.global_rotation)
	var local_point :Vector3=quaterinon.inverse()* to_rotate
	return local_point


static func generate_code_from_nodes_at_right_of_node(nodes:Array[Node], node_center:Node3D, get_code_method_name:String="get_code") -> Array[String]:
	var node_and_position:Array[CodeAndGlobalPosition] = extract_code_from_nodes_and_position(nodes, get_code_method_name)
	var node_and_distance:Array[CodeAndDistance] = [ ]
	for script_node_3d in node_and_position:
		if script_node_3d :
			var gp:Vector3 = script_node_3d.get_global_position()
			var local_position:Vector3 = relocated_global_to_local(node_center,gp)
			local_position.y = 0
			local_position.z = 0
			var distance:float = local_position.length()
			node_and_distance.append(CodeAndDistance.new(script_node_3d.get_code(), distance))

	node_and_distance.sort_custom(func(a, b): return a.get_distance() < b.get_distance())

	var result:Array[String] = []
	for code_and_distance in node_and_distance:
		result.append(code_and_distance.get_code())

	return result
	
static func generate_code_from_nodes_from_center(nodes:Array[Node], node_center:Node3D, get_code_method_name:String="get_code") -> Array[String]:
	var node_and_position:Array[CodeAndGlobalPosition] = extract_code_from_nodes_and_position(nodes, get_code_method_name)
	var node_and_distance:Array[CodeAndDistance] = [ ]
	for script_node_3d in node_and_position:
		if script_node_3d :
			var gp:Vector3 = script_node_3d.get_global_position()
			var local_position:Vector3 = relocated_global_to_local(node_center,gp)
			var distance:float = local_position.length()
			node_and_distance.append(CodeAndDistance.new(script_node_3d.get_code(), distance))

	node_and_distance.sort_custom(func(a, b): return a.get_distance() < b.get_distance())

	var result:Array[String] = []
	for code_and_distance in node_and_distance:
		result.append(code_and_distance.get_code())

	return result
			
			
static func generate_code_from_nodes(nodes:Array[Node], get_code_method_name:String="get_code") -> Array[String]:
	var result:Array[String] = []
	for node in nodes:
		var code:String = extract_code_from_single_node(node, get_code_method_name)
		if code!=null:
			result.append(code)
	return result

static func extract_code_from_nodes_and_position(nodes:Array[Node], get_code_method_name:String="get_code") -> Array[CodeAndGlobalPosition]:
	var result:Array[CodeAndGlobalPosition] = []
	for node in nodes:
		var code_and_position:CodeAndGlobalPosition = extract_code_from_single_node_and_position(node, get_code_method_name)
		if code_and_position!=null:
			result.append(code_and_position)
	return result

static func extract_code_from_single_node_and_position(node:Node, get_code_method_name:String="get_code") -> CodeAndGlobalPosition:
	var code:String = extract_code_from_single_node(node, get_code_method_name)
	if code!="" and code!=null:
		var position:Vector3 = Vector3.ZERO
		if node is Node3D:
			position = node.global_position
		return CodeAndGlobalPosition.new(code, position)
	return null
	

static func extract_code_from_single_node(node:Node, get_code_method_name:String="get_code") -> String:
	if node.has_method(get_code_method_name):
		var code:String = node.call(get_code_method_name)
		return code
	return ""


static func get_all_childrens_recursively_having_code_method_from_array(nodes:Array[Node], get_code_method_name:String="get_code") -> Array[Node]:
	var result:Array[Node] = []
	for n in nodes:
		if n.has_method(get_code_method_name):
			result.append(n)
		for child in n.get_children():
			var local_nodes : Array[Node]= get_all_childrens_recursively_having_code_method_from_array([child], get_code_method_name)
			result.append_array(local_nodes)
	return result

static func get_all_nodes_no_recursively_having_code_method_from_array(nodes:Array[Node], get_code_method_name:String="get_code") -> Array[Node]:
	var result:Array[Node] = []
	for n in nodes:
		if n.has_method(get_code_method_name):
			result.append(n)
	return result
	


static func get_all_childrens_not_recusively_from_array(nodes:Array[Node]) -> Array[Node]:
	var result:Array[Node] = []
	for n in nodes:
		var local_nodes : Array[Node]= get_all_childrens_not_recusively(n)
		result.append_array(local_nodes)
	return result	

static func get_all_nodes_in_childrens_recursive_from_array(nodes:Array[Node]) -> Array[Node]:
	var result:Array[Node] = []
	for n in nodes:
		var local_nodes : Array[Node]= get_all_nodes_in_childrens_recursive(n)
		result.append_array(local_nodes)
	return result


static func get_all_childrens_not_recusively(node:Node) -> Array[Node]:
	var result:Array[Node] = []
	result.append(node)
	for child in node.get_children():
		result.append(child)
	return result


static func get_all_nodes_in_childrens_recursive(node:Node)->Array[Node]:
	var result:Array[Node] = []
	var queue:Array[Node] = [node]
	while queue.size() > 0:
		var current = queue.pop_front()
		for child in current.get_children():
			result.append(child)
			queue.append(child)	
	return result




class CodeAndGlobalPosition:
	
	func _init(code:String, position:Vector3):
		self.code = code
		self.code_global_position = position

	var code_global_position:Vector3
	var code:String
	
	func get_code()->String:
		return code
		
	func get_global_position()->Vector3:
		return code_global_position
		

	
class CodeAndDistance:
	
	func _init(code:String, distance:float):
		self.code = code
		self.distance = distance

	var distance:float
	var code:String
	
	func get_code()->String:
		return code
		
	func get_distance()->float:
		return distance
		
		
