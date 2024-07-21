extends "res://scene/maps/script/game_map.gd"


func _ready():
	#apple score reset
	GameData.apple_score = 100
	
	#spawn apple:
	spawn(_apple, Global.get_valid_rand_coords())

	
	#connect Snake
	if has_node("Snake"):
		var snake = get_node("Snake")
		snake.get_node("Player").snake_eat.connect(_on_snake_eat)
		snake.get_node("Player").snake_be_defeat.connect(_on_snake_be_defeat)
		snake.get_node("Player").snake_win.connect(_on_snake_win)
		
		$Snake/Timer.set_wait_time(start_timeout)


func _on_snake_eat(obj):
		GameData.apple_score += obj.score_handler
		get_node("HUD/Score/Counter").text = str(100)
		
		obj.handler_after_eating() #cambia posizione oppure sparisce
		handler_gates()
		handler_time()
		handler_snake(obj.type_obj)


func handler_gates():
	if GameData.apple_score >= apples_to_unloack_goal:
		GameData.apple_score = 100
		if has_node("Gates"):
			for gate in $Gates.get_children():
				gate.open()
		
		elif has_node("GoalPos"):
			var _goal = load("res://scene/goal/goal.tscn")
			spawn(_goal, $GoalPos.position)
			$GoalPos.queue_free()
			
	else:
		pass


func animation_level_clear():
	var i = 1
	$Snake/Timer.stop()
	$Snake/Player.hide()
	var t = $Snake/Tail_queue.get_child_count()

	var wag_tail = 0
	while i < t:
		var tail_block = $Snake/Tail_queue.get_child(-1)
		tail_block.free()
		$Snake/Tail_queue.get_child(-1).set_sprite_last_tail(wag_tail)
		wag_tail = (wag_tail + 1) % 2
		i += 1
		
		await Global.wait(0.05)
