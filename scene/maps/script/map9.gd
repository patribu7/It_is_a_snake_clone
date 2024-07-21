extends "res://scene/maps/script/game_map.gd"

var bite = false

func _ready():
	ready_game_map()
	
	var velocity_list = [
		Vector2.UP,
		Vector2.UP,
		Vector2.UP,
		Vector2.UP,
		Vector2.LEFT,
		Vector2.UP,
		Vector2.UP,
		Vector2.LEFT,
		Vector2.LEFT,
		Vector2.DOWN,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.LEFT,
		Vector2.UP,
		Vector2.UP,
		Vector2.LEFT,
		Vector2.LEFT
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
