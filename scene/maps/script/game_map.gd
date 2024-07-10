extends Node

var _apple = preload("res://scene/apple/apple.tscn")

@export var start_timeout = 1.0
@export var decr_timeout = 0.1
@export var timeout_min = 0.1

@export var apples_to_unloack_goal = 1

func ready_game_map():
	#apple score reset
	GameData.apple_score = 0
	spawn(_apple, Global.get_rand_coords())
	
	if has_node("Snake"):
		var snake = get_node("Snake")
		snake.get_node("Player").area_entered.connect(_on_player_entered)
		$Snake/Timer.set_wait_time(start_timeout)


func _on_player_entered(area):
	print("collide with: ", area)
	if area.snake_can == "eat":
		handle_eats(area)
		
	elif area.snake_can == "be_defeat":
		var game = get_parent()
		
		if game.name == "Game":
			game.emit_signal("defeat")
		
		else:
			print("defeat!")
	
	elif area.snake_can == "win":
		var game = get_parent()
		
		if game.name == "Game":
			game.stage_clear.emit()
		
		else:
			print("win!")

	
func handle_eats(obj):
		GameData.apple_score += obj.score_handler
		obj.handler_after_eating() #cambia posizione oppure sparisce
		
		#func handler_gates issue
		if GameData.apple_score >= apples_to_unloack_goal:
			if has_node("Gates"):
				for gate in $Gates.get_children():
					gate.open()
			
			elif has_node("GoalPos"):
				var _goal = load("res://scene/goal/goal.tscn")
				spawn(_goal, $GoalPos.position)
				
		else:
			pass
			
		handler_time()
		handler_snake(obj.type_obj)

			
func handler_snake(type):
	if type == "apple":
		$Snake.stretch()
	
	elif type == "spider":
		$Snake.leave_tail()


func handler_time():
		var timeout = update_timer()
		$Snake/Timer.set_wait_time(timeout)


func spawn(_obj, pos:Vector2):
	var obj = _obj.instantiate()
	obj.take_position(pos)
	self.add_child(obj)
	return obj


func update_timer():
	var timeout = start_timeout - (log(GameData.apple_score + 1) * decr_timeout)
	if timeout < timeout_min:
		timeout = timeout_min
	
	return timeout
