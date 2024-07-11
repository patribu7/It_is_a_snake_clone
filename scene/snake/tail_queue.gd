extends Node2D

var _tail = preload("res://scene/snake/tail.tscn")
var wag_tail = 0

func move(player_pos:Vector2, player_velocity):
	var tail_block = get_child(-1)
	move_child(tail_block, 0)
	
	get_child(-1).set_sprite_last_tail(wag_tail)
	wag_tail = (wag_tail + 1) % 2
	
	tail_block.position = player_pos
	tail_block.velocity = player_velocity
	
	tail_block.set_sprite(get_child(1).velocity)
	tail_block.show()


func add_tail(pos):
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
		last_tail.position += Vector2(350, 350) #issue numero magico ottenuto ad occhio fatto in base ad una griglia 750x750
		map.add_child(last_tail)
