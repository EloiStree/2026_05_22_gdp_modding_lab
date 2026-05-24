class_name ModDownloadImageFromUrl
extends Node

signal on_image_loaded_as_texture(texture: Texture2D)
signal on_image_loaded_as_image(image: Image)
signal on_image_loaded_failed()


@export var url_to_download:String
@export var download_at_read:bool=true


var http := HTTPRequest.new()

func _ready():
	add_child(http)
	http.request_completed.connect(_on_request_completed)
	if download_at_read:
		load_image(url_to_download)

func load_image(url: String):
	var err = http.request(url)
	if err != OK:
		push_error("Request failed: %s" % err)

func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		push_error("HTTP error: %s" % response_code)
		return

	var image := Image.new()

	# Try PNG first
	var err = image.load_png_from_buffer(body)

	# Fallback to JPG
	if err != OK:
		err = image.load_jpg_from_buffer(body)

	if err != OK:
		push_error("Could not decode image")
		return

	var texture := ImageTexture.create_from_image(image)

	# Emit signal with Texture2D
	on_image_loaded_as_texture.emit(texture)
	var img:Image = texture.get_image()
	img.decompress()
	on_image_loaded_as_image.emit(img)
	
