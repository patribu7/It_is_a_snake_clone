extends Node

signal start_level

var states = {
	"main_menu": true,
	"run": false,
	"paused": true,
	"stage_clear": true,
	"game_over": true
}

var state_game = "main_menu":
	set(value):
		state_game = value
		$Game.get_tree().paused = states[state_game]

func _ready():
	GameData.load_data()
	#connessioni
	$Game.defeat.connect(_on_defeat)
	$Game.stage_clear.connect(_on_stage_clear)
	$GUI/Menu.request.connect(_on_request)
	
	#dimensioni dello schermo
	var screen_size = get_tree().root.get_window().size
	Global.grid_size = screen_size / Global.tile_size
	
	#paused the game by default
	$Game.get_tree().paused = true
	

func _input(event):
	if event.is_action_pressed("pause") and (state_game == "run" or state_game == "paused"):
		
		if state_game == "run":
			state_game = "paused"
			
		elif state_game == "paused":
			state_game = "run"
		
		$GUI.toggle_menu(state_game)


func _on_request(type:String, lv:int):
	if type == "resume":
		resume()
		
	if type == "new_endless":
		start_game_at_level(0)
		
	if type == "continue_story":
		start_game_at_level(lv)
	
	if type == "set_level":
		start_game_at_level(lv)


func go_to_next_lv():
	start_game_at_level($Game.level + 1)


func start_game_at_level(lv):
	$Game.level = lv
	#GameData.check_for_unlocked_levels(lv) #issue forse questo non serve perché basta salvare ogni volta che sbloccon un livello ovvero ogni volta che è settato unlock_levels
	GameData.current_level = lv
	
	var can_go = $Game.set_new_game()

	if can_go:
		var box_panel = $GUI.open_desc_senario()
		box_panel.start.connect(_on_start)


func _on_start():
	state_game = "run"
	$GUI.hide_menu()


func _on_stage_clear():
	state_game = "stage_clear"
	$GUI.toggle_menu(state_game)
	GameData.unlocked_next_level_on_clear()
	
	
func _on_defeat():
	state_game = "game_over"
	$GUI.toggle_menu(state_game)
	
	if $Game.level == 0: #0 == endless mode
		GameData.set_record() #registra il record


func resume():
	state_game = "run"
	$GUI.hide_menu()


func _on_request_main_menu():
	$GUI.show()
