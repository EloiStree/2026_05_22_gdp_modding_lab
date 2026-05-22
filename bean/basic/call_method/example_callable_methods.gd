extends Node

@export var light :DirectionalLight3D

func turn_on_light():
	set_light_state(true)

func turn_off_light():
	set_light_state(false)
		
func set_light_state(is_on:bool):
	if is_on:
		light.show()
	else:
		light.hide()
	
func set_random_color():
	set_color(Color( randf() , randf() , randf() ) )

func set_color(color:Color):
	light.light_color=color
