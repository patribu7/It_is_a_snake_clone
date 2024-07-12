extends "res://scene/cell_block/block.gd"

var velocity: Vector2


func _init():
	snake_can = "be_defeat"
	velocity = Vector2.UP


func set_sprite(velocity_behind):
	$Sprite.rotation = 0

	if velocity_behind != velocity: #se cambia direzione
		$Sprite.play("angle")
		
		if velocity_behind.y * velocity.x > velocity_behind.x * velocity.y: 
#			counterclockwise
			$Sprite.rotation = velocity.angle() - PI/2
		
		else:
#			clockwise
			$Sprite.rotation = velocity.angle()
			
	else: #se non cambia direzione
		$Sprite.play("default")
		$Sprite.rotation = velocity.angle()


func set_sprite_last_tail(wag_tail):
	$Sprite.play("end_tail")
	$Sprite.frame = wag_tail

	$Sprite.rotation = velocity.angle() + PI/2
	
	
