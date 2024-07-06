extends "res://scene/cell_block/block.gd"

func _init():
	snake_can = "eat"
	type_obj = "spider"

func take_position(pos):
		global_position = pos


func hendler_after_eating():
	take_position(Global.get_rand_coords())
