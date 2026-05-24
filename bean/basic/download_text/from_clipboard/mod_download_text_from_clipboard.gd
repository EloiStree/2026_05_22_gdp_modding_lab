class_name ModDownloadTextFromClipboard
extends Node

signal on_text_downloaded_from_clipboard(text:String)
signal on_text_downloaded_from_clipboard_changed(text:String)

@export var load_clipboard_at_ready:bool
@export_group("Debug")
@export_multiline() var previous_download:String

func _ready():
	if load_clipboard_at_ready:
		download_text_from_clipboard()
		
func download_text_from_clipboard() -> void:
	var clipboard_text:String = get_text_from_clipboard()
	var has_changed:bool = clipboard_text!= previous_download
	if has_changed:
		on_text_downloaded_from_clipboard_changed.emit(clipboard_text)
	on_text_downloaded_from_clipboard.emit(clipboard_text)

static func get_text_from_clipboard() -> String:
	return DisplayServer.clipboard_get()
