extends "res://scene/cell_block/block.gd"



func _init():
	snake_can = "eat"
	type_obj = "apple"


func handler_after_eating():
	take_position(Global.get_rand_coords())


func _on_area_entered(area):
	if area.type_obj != "player":
		take_position(Global.get_rand_coords())
