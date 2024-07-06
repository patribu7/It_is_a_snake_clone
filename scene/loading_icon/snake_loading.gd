extends Node2D

var last_pos
var i = 1
var ii = 0

func move():
	last_pos = $Player.position
	$Tail_queue.move($Player.position, $Player.velocity)
	$Player.move()


func _on_timer_timeout():
	i += 1
	
	if i > 1:
		i = 0
		change_direction()
		ii += 1
	
		if ii > 3:
			ii = 0
	
	move()


func change_direction():
	$Player.current_dir = $Player.dir[ii]
