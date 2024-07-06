extends Node

var grid_size = Vector2i(15, 15)
var tile_size = Vector2i(50, 50) 

func convert_grid_coords_in_px(pos_grid: Vector2):
	#convert a position into GameGrid to coords in px
	assert(pos_grid >= Vector2.ONE, "can't assign a position < (1, 1)")

	var pos = Vector2.ZERO
	
	pos.x = pos_grid.x * tile_size.x - tile_size.x
	pos.y = pos_grid.y * tile_size.y - tile_size.y
	
	return pos


func get_rand_coords():
	var rand_x = randi_range(1, grid_size.x)
	var rand_y = randi_range(1, grid_size.y)
	var coords = convert_grid_coords_in_px(Vector2i(rand_x, rand_y))
	
	return coords


func wait(sec:float):
	await get_tree().create_timer(sec).timeout
