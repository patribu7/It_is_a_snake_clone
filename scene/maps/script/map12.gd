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
		
	$Hole.invalid_pos = [
	Vector2(0, 0),
	Vector2(0, 50),
	Vector2(0, 100),
	Vector2(50, 0),
	Vector2(50, 50),
	Vector2(50, 100),
	Vector2(100, 0),
	Vector2(100, 50),
	Vector2(100, 100)
]
