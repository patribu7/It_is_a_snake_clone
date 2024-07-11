extends "res://scene/cell_block/block.gd"

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
	current_velocity = velocity
	$Sprite.rotation = velocity.angle()
	
	pacman_effect()


func set_sprite_crash(in_pos):
	position = in_pos
	$Sprite.play("crash")
	


func set_sprite_eat():
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
