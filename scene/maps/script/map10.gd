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
		
		$Snake/Timer.set_wait_time(update_timer())


var dir = 50
func get_direction():
	if has_node("Apple"):
		if $Apple/RayLeft.is_colliding():
			dir = 50
	
		if $Apple/RayRight.is_colliding():
			dir = -50


func _on_timer_map_timeout():
	get_direction()
	if has_node("Apple"):
		$Apple.position.x += dir
	pacman_effect()


func _on_timer_snake_timeout():
	$Snake/Timer.wait_time = update_timer()


func handler_time():
		pass


func update_timer():
	var timeout = randi_range(1, 20)
	return timeout * 0.1

func pacman_effect():
	var vector_min = Vector2.ZERO
	var vector_max = Global.convert_grid_coords_in_px(Global.grid_size)

	if has_node("Apple"):
		if $Apple.position.x < vector_min.x:
			$Apple.position.x = vector_max.x
		
		if $Apple.position.x > vector_max.x:
			$Apple.position.x = vector_min.x
