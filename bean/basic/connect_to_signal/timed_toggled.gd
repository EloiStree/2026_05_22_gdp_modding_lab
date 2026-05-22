extends Node

signal toggled(is_on:bool)

@export var toggled_state:bool
@export var time_between_toggled:float=1

func _ready() -> void:
	while true:
		await get_tree().create_timer(time_between_toggled).timeout
		change_toggled_state()

func change_toggled_state() -> void:
	toggled_state = !toggled_state
	toggled.emit(toggled_state)
