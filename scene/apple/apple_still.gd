extends "res://scene/apple/apple.gd"

func _on_area_entered(_area):
	queue_free()
