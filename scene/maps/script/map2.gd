extends "res://scene/maps/script/game_map.gd"

func _ready():
	ready_game_map()
	#e' nervoso, quindi corre piu' veloce dall'inizio
	
	var velocity_list = [Vector2.UP, Vector2.UP, Vector2.RIGHT, Vector2.RIGHT, Vector2.RIGHT, Vector2.RIGHT, Vector2.RIGHT]
	set_velocity_for_tail_in_scene(velocity_list)
	
