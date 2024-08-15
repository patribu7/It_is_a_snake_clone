extends "res://scene/maps/script/game_map.gd"




func _ready():
		#apple score reset
	GameData.apple_score = 0
	
	#connect Snake
	if has_node("Snake"):
		var snake = get_node("Snake")
		snake.get_node("Player").snake_eat.connect(_on_snake_eat)
		snake.get_node("Player").snake_be_defeat.connect(_on_snake_be_defeat)
		snake.get_node("Player").snake_win.connect(_on_snake_win)
		
		$Snake/Timer.set_wait_time(start_timeout)
