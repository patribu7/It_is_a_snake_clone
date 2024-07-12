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


func _input(event):
	for dir in inputs.keys():
		#sanke can't turn back!
		if event.is_action_pressed(dir) and (inputs[dir] + current_velocity) != Vector2.ZERO:
			velocity = inputs[dir]


func move():
	position += velocity * size
	$Sprite.rotation = velocity.angle()
	current_velocity = velocity

	pacman_effect()


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
	
	if global_position.x < vector_min.x:
		global_position.x = vector_max.x
		
	if global_position.y < vector_min.y:
		global_position.y = vector_max.y
		
	if global_position.x > vector_max.x:
		global_position.x = vector_min.x
		
	if global_position.y > vector_max.y:
		global_position.y = vector_min.y


func get_collision():
	for ray in get_node("Rays").get_children():
		if ray.is_colliding() and (velocity + ray.get_meta("Velocity")) != Vector2.ZERO and velocity == ray.get_meta("Velocity"):
			var area = ray.get_collider()
			
			if area.snake_can == "eat":  #issue e se è uno spider?
				set_sprite_eat_apple()
				snake_eat.emit(area)

			elif area.snake_can == "be_defeat":
				snake_be_defeat.emit()
				set_sprite_crash()
				return "on_obstacle"
			
			elif area.snake_can == "win":
				snake_win.emit()

	
	
	
