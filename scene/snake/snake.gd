extends Node2D

var last_pos

func move():
	last_pos = $Player.position
	$Tail_queue.move($Player.position, $Player.velocity)
	$Player.move()

	
func stretch():
	$Tail_queue.add_tail(last_pos)


func leave_tail():
	$Tail_queue.lost_tail()


func take_position(pos):
		global_position = pos


func _on_timer_timeout():
	move()


func show_crash():
	$Player.set_sprite_crash(last_pos)
	$Tail_queue.get_child(0).hide()


func show_eat():
	$Player.set_sprite_eat()
