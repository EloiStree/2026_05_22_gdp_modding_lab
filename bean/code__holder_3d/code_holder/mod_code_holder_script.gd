class_name ModCodeHolderScript
extends Node

@export var code_as_script:Script

func get_code()->String:
	return code_as_script.source_code
		
func get_script()->Script:
	return code_as_script
		
func has_script()->bool:
	return code_as_script!=null
