extends Node

signal request_main_menu

func _on_press_any_key():
	queue_free()
	request_main_menu.emit()
