extends "res://scene/cell_block/block.gd"

func _init():
	snake_can = "win"


func _on_area_overlying(area):
	if area.name != "Player":
		area.collision_mask = 2
		area.collision_layer = 2


func _on_area_exited(area):
	area.collision_mask = 1
	area.collision_layer = 1
