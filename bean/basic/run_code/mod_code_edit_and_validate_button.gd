class_name ModCodeEditAndSubmitButton
extends Node

signal on_code_submit(text:String)

@export var code_editor: CodeEdit
@export var submit_button: Button


func _ready() -> void:
	submit_button.pressed.connect(_on_submit_button_pressed)


func _on_submit_button_pressed() -> void:
	var code = code_editor.text
	on_code_submit.emit(code)
