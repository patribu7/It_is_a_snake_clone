extends "res://scene/cell_block/block.gd"

func _init():
	snake_can = "win"


func _on_area_overlying(area):
	if area.name != "Player":
		area.collision_mask = 0
		area.collision_layer = 0
	

