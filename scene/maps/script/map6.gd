extends "res://scene/maps/script/game_map.gd"

var _gate = preload("res://scene/gate/gate.tscn")

func _ready():
	ready_game_map()
	#issue --> da implementare gestione delle code al cambio livello
	#apple score reset
	GameData.apple_score = 0

	
	if has_node("Snake2"):
		var snake = get_node("Snake2")
		snake.get_node("Player").area_entered.connect(_on_player_entered)
		$Snake2/Timer.set_wait_time(start_timeout)


func handler_time():
		var timeout = update_timer()
		$Snake/Timer.set_wait_time(timeout)
		$Snake2/Timer.set_wait_time(timeout)
