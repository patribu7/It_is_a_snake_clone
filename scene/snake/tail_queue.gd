extends Node2D

var _tail = preload("res://scene/snake/tail.tscn")
var wag_tail = 0

func move(player_pos:Vector2, player_velocity):
	var tail_block = get_child(-1)
	move_child(tail_block, 0)
	tail_block.position = player_pos
	tail_block.velocity = player_velocity
	tail_block.set_sprite(get_child(1).velocity)
	
	get_child(-1).set_sprite_last_tail(wag_tail)
	wag_tail = (wag_tail + 1) % 2
	
	tail_block.show() #se non è visibile nel caso sia stata aggiunta con stretch()


func add_tail(pos): #issue nel caso la mela appaia all'inizio questo nodo non è pronto e crasha
	var num = get_child_count() + 1
	var tail = _tail.instantiate()
	tail.name += str(num)
	
	tail.position = pos
	
	tail.hide()
	
	self.call_deferred("add_child", tail)


func lost_tail():
	if get_child_count() > 2:
		var last_tail = get_child(-1)
		var map = get_parent().get_parent()
		
		remove_child(last_tail)
		last_tail.position += Vector2(300, 300) #issue numero magico. è la posizione di snake
		map.add_child(last_tail)

		last_tail.get_node("Sprite").sprite_frames.set_animation_speed("end_tail", 2.0)
	
		
		
