extends Node

@export var frame_count:int=0
func _ready() -> void:
	print("Hello World")

func _process(delta: float) -> void:
	frame_count+=1
