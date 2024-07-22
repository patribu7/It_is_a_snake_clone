extends "res://scene/cell_block/block.gd"

func _init():
	snake_can = "eat"
	type_obj = "apple"


func handler_after_eating():
	take_position(Global.get_valid_rand_coords())
