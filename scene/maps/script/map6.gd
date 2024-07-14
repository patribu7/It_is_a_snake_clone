extends "res://scene/maps/script/game_map.gd"

var is_win = false

func _ready():
	#apple score reset
	GameData.apple_score = 0
	
	spawn(_apple, Global.get_valid_rand_coords())
	
	$Timer.set_wait_time(start_timeout)
	
	if has_node("Snake"):
		var snake = get_node("Snake")
		snake.get_node("Player").snake_eat.connect(_on_snake_eat)
		snake.get_node("Player").snake_be_defeat.connect(_on_snake_be_defeat)
		snake.get_node("Player").snake_win.connect(_on_snake_win)
	
	if has_node("Snake2"):
		var snake2 = get_node("Snake2")
		snake2.get_node("Player").snake_eat.connect(_on_snake_eat)
		snake2.get_node("Player").snake_be_defeat.connect(_on_snake_be_defeat)
		snake2.get_node("Player").snake_win.connect(_on_snake_win)


func handler_time():
		var timeout = update_timer()
		$Timer.set_wait_time(timeout)
		
		
func animation_level_clear():
	var i = 0
	$Timer.stop()
	$Snake2/Player.hide()
	$Snake2/Tail_queue.is_animation_win = true
	while i < 2:
		$Snake2/Tail_queue.move($Snake2/Player.position, Vector2.ZERO)
		$Snake2/Tail_queue.get_child(0).free()
		i += 1
		
		await Global.wait(0.15)


func _on_snake_be_defeat():
	var game = get_parent()
	
	if not is_win:
		
		if game.name == "Game":
			game.emit_signal("defeat")
		
		else:
			print("defeat!")


func _on_snake_win():
	is_win = true
	await animation_level_clear()

	var game = get_parent()
	if game.name == "Game":
		game.stage_clear.emit()
		
	else:
		print("win!")
