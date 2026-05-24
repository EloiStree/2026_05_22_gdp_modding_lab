class_name ModCodeHolderText3D
extends Node3D


signal on_code_updated(new_code_as_text:String)
signal on_code_changed(new_code_as_text:String)

@export_multiline() var code_as_text:String

func get_code()->String:
	return code_as_text


func set_code(code_as_text)->void:
	var new_code_as_text = code_as_text if code_as_text!=null else ""
	var has_changed = self.code_as_text != new_code_as_text
	if has_changed:
		self.code_as_text = new_code_as_text
		on_code_changed.emit(new_code_as_text)
	on_code_updated.emit(new_code_as_text)
	
	
func set_code_with_script(script:Script)->void:
	set_code(script.source_code)
