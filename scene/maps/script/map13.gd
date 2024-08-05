extends "res://scene/maps/script/game_map.gd"


func _ready():
	#apple score reset
	GameData.apple_score = 0
	
	#connect Snake
	if has_node("Snake"):
		var snake = get_node("Snake")
		snake.get_node("Player").snake_eat.connect(_on_snake_eat)
		snake.get_node("Player").snake_be_defeat.connect(_on_snake_be_defeat)
		snake.get_node("Player").snake_win.connect(_on_snake_win)


func _on_timer_timeout():
	$Background.position.y += 50
	$Apples.position.y += 50
	
	for apple in $Apples.get_children():
		if apple.global_position.y == 200:
			fall(apple)


func fall(obj):
	while obj.global_position.y <= 700:
		obj.global_position.y += 10
		await Global.wait(0.1)

	obj.global_position.y = 700
