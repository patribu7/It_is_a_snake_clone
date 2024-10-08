extends Node

var _apple = preload("res://scene/apple/apple.tscn")

@export var start_timeout: float
@export var decr_timeout: float
@export var timeout_min = 0.1

@export var apples_to_unloack_goal = 1


func ready_game_map():
	#apple score reset
	GameData.apple_score = 0
	
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
		
		obj.handler_after_eating() #cambia posizione oppure sparisce
		handler_gates()
		handler_time()
		handler_snake(obj.type_obj)
	
	
func _on_snake_be_defeat():
	var game = get_parent()
	
	if game.name == "Game":
		game.emit_signal("defeat")
		
	else:
		print("defeat!")


func _on_snake_win():
	await animation_level_clear()

	var game = get_parent()
	if game.name == "Game":
		game.stage_clear.emit()
		
	else:
		print("win!")


func animation_level_clear():
	var i = 1
	$Snake/Timer.stop()
	$Snake/Player.hide()
	var t = $Snake/Tail_queue.get_child_count() - (GameData.apple_score - apples_to_unloack_goal) #issue sarebbe meglio metterlo come property cosi' e' piu' facile modificarlo nelle children anziche' sistituire l'intera funzione ogni volta

	var wag_tail = 0
	while i < t:
		var tail_block = $Snake/Tail_queue.get_child(-1)
		tail_block.free()
		$Snake/Tail_queue.get_child(-1).set_sprite_last_tail(wag_tail)
		wag_tail = (wag_tail + 1) % 2
		i += 1
		
		await Global.wait(0.05)


func handler_gates():
	if GameData.apple_score == apples_to_unloack_goal:
		if has_node("Gates"):
			for gate in $Gates.get_children():
				gate.open()
		
		elif has_node("GoalPos"):
			var _goal = load("res://scene/goal/goal.tscn")
			spawn(_goal, $GoalPos.position)
			$GoalPos.queue_free()
			
	else:
		pass

			
func handler_snake(type):
	if type == "apple":
		$Snake.stretch()
	
	elif type == "spider":
		$Snake.leave_tail()


func handler_time():
		var timeout = update_timer()
		$Snake/Timer.set_wait_time(timeout)


func update_timer():
	var timeout = start_timeout - (log(GameData.apple_score + 1) * decr_timeout)
	if timeout < timeout_min:
		timeout = timeout_min
	
	return timeout


func spawn(_obj, pos:Vector2):
	var obj = _obj.instantiate()
	obj.take_position(pos)
	self.add_child(obj)
	return obj


func set_velocity_for_tail_in_scene(velocity_list:Array):
	#imposto la velocity per ogni coda in scena per poter orientare l'ultima coda una volta che snake si muove
	var i = 0
	for tail in $Snake/Tail_queue.get_children():
		tail.velocity = velocity_list[i]
		i += 1
