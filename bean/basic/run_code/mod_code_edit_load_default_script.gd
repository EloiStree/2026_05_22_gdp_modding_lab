class_name ModCodeEditLoadDefaultScript
extends Node


signal on_code_loaded_as_text(text:String)

@export var script_to_load: Script 
@export var load_at_ready:bool=true

@export var text_editr_to_affect:Array[TextEdit]

func _ready() -> void:
	if load_at_ready:
		load_script_as_text()

func load_script_as_text() -> void:
	var code :String = script_to_load.source_code
	for text_edit in text_editr_to_affect:
		text_edit.text = code
	on_code_loaded_as_text.emit(code)
