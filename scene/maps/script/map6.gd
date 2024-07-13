extends "res://scene/maps/script/game_map.gd"

func _ready():
	#apple score reset
	GameData.apple_score = 0
	
	spawn(_apple, Global.get_valid_rand_coords())
	
	if has_node("Snake"):
		var snake = get_node("Snake")
		snake.get_node("Player").snake_eat.connect(_on_snake_eat)
		snake.get_node("Player").snake_be_defeat.connect(_on_snake_be_defeat)
		snake.get_node("Player").snake_win.connect(_on_snake_win)
		$Snake/Timer.set_wait_time(start_timeout)
	
	if has_node("Snake2"):
		var snake2 = get_node("Snake2")
		snake2.get_node("Player").snake_eat.connect(_on_snake_eat)
		snake2.get_node("Player").snake_be_defeat.connect(_on_snake_be_defeat)
		snake2.get_node("Player").snake_win.connect(_on_snake_win)
		$Snake2/Timer.set_wait_time(start_timeout)


func handler_time():
		var timeout = update_timer()
		$Snake/Timer.set_wait_time(timeout)
		$Snake2/Timer.set_wait_time(timeout)

