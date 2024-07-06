extends Node2D

signal defeat
signal stage_clear

var level = 0

func clean_grid():
	if has_node("Map"):
		$Map.free()


func load_map():
	var path_to_map = "res://scene/maps/map%s.tscn" % level

	if ResourceLoader.exists(path_to_map):
		var map = load(path_to_map).instantiate()
		call("add_child", map)
	
		return true
	
	else:
		return false


func set_new_game():
	clean_grid()
	
	var is_map_load = load_map()
	
	if not is_map_load:
		print("can't find the map you selected")
	
	return  is_map_load
