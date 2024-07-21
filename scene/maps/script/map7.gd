extends "res://scene/maps/script/game_map.gd"

var exited_from_hole = false

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


func _on_timeout():
	if exited_from_hole:
		$Snake.stretch()


func _on_hole_entered(_area):
	print("collision")
	exited_from_hole = true
	$Snake/Player.global_position = $Hole.teleport_pos
