extends "res://scene/maps/script/game_map.gd"

var _gate = preload("res://scene/gate/gate.tscn")

func _ready():
	
	if has_node("Snake"):
		var snake = get_node("Snake")
		snake.get_node("Player").area_entered.connect(_on_player_entered)
		$Snake/Timer.set_wait_time(start_timeout)

	#issue --> da implementare gestione delle code al cambio livello
	#apple score reset
	GameData.apple_score = 0
