extends Node

var grid_size = Vector2i(15, 15)
var tile_size = Vector2i(50, 50) 

func convert_grid_coords_in_px(pos_grid: Vector2):
	#convert a position into GameGrid to coords in px
	assert(pos_grid >= Vector2.ONE, "can't assign a position < (1, 1)")

	var pos = Vector2.ZERO # as void
	
	pos.x = pos_grid.x * tile_size.x - tile_size.x
	pos.y = pos_grid.y * tile_size.y - tile_size.y
	
	return pos


func get_valid_rand_coords():
	
	var rand_x = randi_range(1, grid_size.x)
	var rand_y = randi_range(1, grid_size.y)
	var coords = convert_grid_coords_in_px(Vector2i(rand_x, rand_y))

	var list_pos_occupied = get_occupied_cells(get_parent()) #issue get_parent() di comodo. Funziona solo se non è un sottonodo

	while not is_free_cell(coords, list_pos_occupied):
		rand_x = randi_range(1, grid_size.x)
		rand_y = randi_range(1, grid_size.y)
		coords = convert_grid_coords_in_px(Vector2i(rand_x, rand_y))
	
	return coords


func get_occupied_cells(node):
	var pos_occupied = []
	for obj in node.get_tree().get_nodes_in_group("solid_obj"):
		pos_occupied.append(obj.position)
	
	return pos_occupied


func is_free_cell(pos, list_pos_cells):
	var position_is_free = true
		
	for pos_occupied in list_pos_cells: #issue get_parent funziona solo partendo dal presupposto che sia direttamente nella mappa e non in un sottonodo
		if pos_occupied == pos:
			position_is_free = false
			print("position not valid: ", pos, " changing position")
	
	return position_is_free


func wait(sec:float):
	await get_tree().create_timer(sec).timeout
