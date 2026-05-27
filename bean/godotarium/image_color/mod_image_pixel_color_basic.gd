class_name ModImagePixelColorBasic
extends Node

@export var current_texture:Texture2D
@export_group("Debug")
@export var current_image:Image
@export var image_width:float
@export var image_height:float

func _ready() -> void:
	load_texture(current_texture)

func load_texture(texture:Texture2D):
	current_texture=texture
	if current_texture == null:
		return
	current_image = current_texture.get_image()
	current_image.decompress()
	image_width = current_image.get_width()
	image_height = current_image.get_height()

func get_pixel_color_default_xy_pixel(x:int, y:int) -> Color:
	if current_image == null:
		return Color.BLACK
	return current_image.get_pixel(x, y)

func get_pixel_color_default_percent(x:float, y:float) -> Color:
	var pixel_x = int(x * image_width)
	var pixel_y = int(y * image_height)
	return get_pixel_color_default_xy_pixel(pixel_x, pixel_y)

func get_pixel_color_from_lrtd_percent(x:float, top_y:float) -> Color:
	return get_pixel_color_default_percent(x, top_y)
	
func get_pixel_color_from_lrdt_percent(x:float, down_y:float) -> Color:
	return get_pixel_color_default_percent(x, 1.0 - down_y)

	
