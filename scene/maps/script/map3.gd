extends "res://scene/maps/script/game_map.gd"


func _ready():
	ready_game_map() #richiamo una funzione nello script originale come se fosse _ready e aggiungo regole al gioco

	var velocity_list = [
		Vector2.UP,
		Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN,
		Vector2.RIGHT,
		Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN,
		Vector2.RIGHT,
		Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN,
		Vector2.RIGHT,
		Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN
		]
	set_velocity_for_tail_in_scene(velocity_list)
