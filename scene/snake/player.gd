extends "res://scene/cell_block/block.gd"

signal snake_eat
signal snake_be_defeat
signal snake_win

var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
}

@export_enum("move_right", "move_left", "move_up", "move_down") var direction = "move_up"

var current_velocity = Vector2.UP
var velocity = inputs[direction]

func _ready():
	type_obj = "snake"
	
	set_ray_velocity()


func _input(event):
	for dir in inputs.keys():
		#sanke can't turn back!
		if event.is_action_pressed(dir) and not event.is_shift_pressed() and (inputs[dir] + current_velocity) != Vector2.ZERO:
			velocity = inputs[dir]


func move():
	position += velocity * size
	$Sprite.rotation = velocity.angle()
	current_velocity = velocity

	pacman_effect()


func set_ray_velocity():
	for ray in $Rays.get_children():
		ray.get_parent_velocity()


func set_sprite_crash():
	if current_velocity == velocity: #se il crash è frontale
		$Sprite.play("frontal_crash")
	
	elif current_velocity.y * velocity.x > current_velocity.x * velocity.y: #se è antiorario
		$Sprite.play("side_crash")
		$Sprite.flip_v = true
	
	else: #se è orario
		$Sprite.play("side_crash")
		$Sprite.flip_v = false


func set_sprite_eat_apple():
	$Sprite.play("eat")
	await $Sprite.animation_finished
	$Sprite.play("default")

	
func pacman_effect():
	var vector_min = Global.convert_grid_coords_in_px(Vector2.ONE)
	var vector_max = Global.convert_grid_coords_in_px(Global.grid_size)
	
	# left
	if global_position.x < vector_min.x:
		global_position.x = vector_max.x
	if global_position.x == vector_min.x:
		$Rays/RayCastLeft.position.x = vector_max.x - global_position.x + 75 #issue numero magico -->
		# --> vector_max è 700 nella griglia l'origine anchor è in alto a sinistra perciò 75 == 25 + cell_size
	else:
		$Rays/RayCastLeft.position.x = 25
		
	# up
	if global_position.y < vector_min.y:
		global_position.y = vector_max.y
	if global_position.y == vector_min.y:
		$Rays/RayCastUp.position.y = vector_max.y - global_position.y + 75
	else:
		$Rays/RayCastUp.position.y = 25
		
	# right
	if global_position.x > vector_max.x:
		global_position.x = vector_min.x
	if global_position.x == vector_max.x:
		$Rays/RayCastRight.position.x = vector_min.x - global_position.x - 25
	else:
		$Rays/RayCastRight.position.x = 25
		
	# down
	if global_position.y > vector_max.y:
		global_position.y = vector_min.y
	if global_position.y == vector_max.y:
		$Rays/RayCastDown.position.y = vector_min.y - global_position.y - 25
	else:
		$Rays/RayCastDown.position.y = 25


func get_collision():
	for ray in $Rays.get_children():
		var area = ray.collider()
		if area != null and velocity == ray.velocity:

			if area.snake_can == "eat":
				snake_eat.emit(area)
				
				if area.type_obj == "apple":
					set_sprite_eat_apple()
				
				elif area.type_obj == "spider":
					pass

			elif area.snake_can == "be_defeat":
				snake_be_defeat.emit()
				set_sprite_crash()
				return "on_obstacle"

			elif area.snake_can == "win":
				snake_win.emit()
			

	
	
	
