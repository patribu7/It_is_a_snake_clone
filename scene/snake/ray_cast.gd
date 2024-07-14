extends RayCast2D

var player_velocity
var velocity

func _ready():
	velocity = get_meta("Velocity")
	print(velocity)


func get_parent_velocity():
	player_velocity = get_parent().get_parent().velocity


func collider():
	if is_colliding():
		return get_collider()
	else:
		return null
