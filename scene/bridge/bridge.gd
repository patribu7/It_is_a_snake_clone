extends "res://scene/cell_block/block.gd"

var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
}

func _init():
	snake_can = "pass_through"


func _on_area_overlying(area):
	if area.name != "Player":
		area.collision_mask = 2
		area.collision_layer = 2
	

func _on_area_exited(area):
	area.collision_mask = 1
	area.collision_layer = 1
	

func _input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir) and Input.is_action_pressed("action_for_shift"):
			position += inputs[dir] * 50
