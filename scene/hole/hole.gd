extends "res://scene/cell_block/block.gd"

var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
}

var invalid_pos = [ #issue questo andrebbe nelle istruzioni della mappa! Non nell'oggetto!
	Vector2(0, 0),
	Vector2(0, 50),
	Vector2(0, 100),
	Vector2(50, 0),
	Vector2(50, 50),
	Vector2(50, 100),
	Vector2(100, 0),
	Vector2(100, 50),
	Vector2(100, 100)
]

func _on_area_entered(area):
	if area.name == "Player":
		area.global_position = $Teleport_pos.global_position + area.velocity * 50


func _input(event):
	var is_valid_pos = true
	
	for dir in inputs.keys():
		
		if event.is_action_pressed(dir) and Input.is_action_pressed("action_for_shift"):
			
			for i_pos in invalid_pos:
				
				if $Teleport_pos.global_position + inputs[dir] * 50 == i_pos:
					is_valid_pos = false
				
			if is_valid_pos:
				$Teleport_pos.global_position += inputs[dir] * 50
				pacman_effect()


func pacman_effect():
	if $Teleport_pos.global_position.x < 0:
		$Teleport_pos.global_position.x = 700
		
	if $Teleport_pos.global_position.x > 700:
		$Teleport_pos.global_position.x = 0

	if $Teleport_pos.global_position.y < 0:
		$Teleport_pos.global_position.y = 700
	
	if $Teleport_pos.global_position.y > 700:
		$Teleport_pos.global_position.y = 0
