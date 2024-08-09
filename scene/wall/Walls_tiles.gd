extends TileMap

const Wall = preload("res://scene/wall/wall.tscn")

func _ready():
	var walls_places = get_used_cells(0)
	place(walls_places)
	
func place(walls):
	for wall_place in walls:
		var wall = Wall.instantiate()
		wall.global_position = Global.convert_grid_coords_in_px(wall_place)
		self.call("add_child", wall)
		
		
