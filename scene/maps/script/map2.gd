extends "res://scene/maps/script/game_map.gd"

func _ready():
	ready_game_map() #richiamo una funzione nello script originale come se fosse _ready e aggiungo regole al gioco
	
	#issue se vieni dal livello 1 hai tante tail quante ne avevi al livello 1, altrimenti hai 2 tail. --> da implementare successivamente
	#apple score reset
	GameData.apple_score = 0
	#e' nervoso, quindi corre piu' veloce dall'inizio
