extends "res://scene/maps/script/game_map.gd"


func _ready():
	ready_game_map() #richiamo una funzione nello script originale come se fosse _ready e aggiungo regole al gioco
	
	#issue --> da implementare gestione delle code al cambio livello
