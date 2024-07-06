extends Area2D

var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
}

var dir = [
	"move_right",
	"move_down",
	"move_left",
	"move_up",
]

var current_dir = "move_right":
	set(value):
		velocity = inputs[value]

var velocity = inputs[current_dir]


func move():
	position += velocity * Vector2(50, 50)

	$Sprite.rotation = velocity.angle()
