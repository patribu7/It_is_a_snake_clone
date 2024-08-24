extends "res://scene/maps/script/game_map.gd"

var bite = false

func _ready():
	ready_game_map()
	
	var velocity_list = [
		Vector2.UP, # 1
		Vector2.UP, # 2
		Vector2.UP, # 3
		Vector2.UP, # 4
		Vector2.LEFT, # 5
		Vector2.UP, # 6
		Vector2.UP, # 7
		Vector2.LEFT, # 8
		Vector2.LEFT, # 9
		Vector2.DOWN, # 10
		Vector2.DOWN, # 11
		Vector2.LEFT, # 12
		Vector2.LEFT, # 13
		Vector2.UP, # 14
		Vector2.UP, # 15
		Vector2.LEFT, # 16
		Vector2.LEFT, # 17
		Vector2.LEFT, # 18
		Vector2.DOWN, # 19
		Vector2.DOWN, # 20
		Vector2.DOWN, # 21
		Vector2.DOWN, # 22
		Vector2.DOWN, # 23
		Vector2.DOWN, # 24
		Vector2.DOWN, # 25
		Vector2.DOWN, # 26
		Vector2.DOWN, # 27
		Vector2.DOWN, # 28
		Vector2.RIGHT, # 29
		Vector2.RIGHT, # 30
		Vector2.RIGHT, # 31
		Vector2.UP, # 32
		Vector2.UP, # 33
		Vector2.RIGHT, # 34
		Vector2.RIGHT, # 35
	]
		
	set_velocity_for_tail_in_scene(velocity_list)


func _on_timer_timeout():
	if not bite:
		$Goal.position = $Snake/Tail_queue.get_child(-1).global_position


func animation_level_clear():
	bite = true
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
