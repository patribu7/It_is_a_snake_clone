extends Control

signal request(type)

var _box_panel = preload("res://scene/gui/box_panel.tscn")

var state_game = "main_menu"

@onready var new_game_btn = get_node("MainMenu/NewGame")

func _ready():
	new_game_btn.grab_focus()


func _on_new_endless():
	clear_box_panel()
	request.emit("new_endless", 0)
	
	
func _on_continue_story():
	clear_box_panel()
	request.emit("continue_story", GameData.unlocked_levels)


func _on_lv_selected(select_lv):
	clear_box_panel()
	request.emit("set_level", select_lv)


func _on_new_game_button_pressed():
	var grid_panel = open_panel("new_game")
	
	grid_panel.get_node("EndlessBtn").button_up.connect(_on_new_endless)
	grid_panel.get_node("StoryBtn").button_up.connect(_on_continue_story)
	
	
func _on_select_lv_button_up():
	open_panel("level_selection")


func _on_credits_button_up():
	open_panel("text_box")


func _on_scenario_btn_button_up():
	open_panel("text_box", true)


func _on_resume_btn_button_up():
	request.emit("resume", 0) # "0" numero che viene poi scartato


func clear_box_panel():
	if has_node("BoxPanel"):
		$BoxPanel.queue_free()
	
		

func _on_quit_button_up():
	var dialog = ConfirmationDialog.new()
	dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_PRIMARY_SCREEN
	dialog.dialog_text = "Quit?"
	add_child(dialog)
	dialog.show()
	
	await dialog.confirmed
	get_tree().quit()


func open_panel(type:String, in_scenario = false):
	clear_box_panel() #se ne esiste un altro aperto lo chiudo
	var box_panel = _box_panel.instantiate()
	box_panel.is_in_scenario = in_scenario
	var context_box = box_panel.add_context(type)

	
	if type == "level_selection":

		for btn in context_box.get_children():
			btn.button_up.connect(_on_lv_selected.bind(int(btn.text)))
	
	add_child(box_panel)
	
	return context_box


func _on_visibility_changed():
	if visible == true and is_instance_valid(new_game_btn):
		clear_box_panel()
		new_game_btn.grab_focus()
	
	if state_game == "paused":
		$MenuPaused.show()
		$MenuPaused/Paused/ResumeBtn.grab_focus()
		
	else:
		$MenuPaused.hide()
		
	if state_game == "game_over":
		$GameOver.show()
		$GameOver/Retry.grab_focus()
	else:
		$GameOver.hide()
	
	if state_game == "stage_clear":
		$StageClear.show()
		$StageClear/NextLevel.grab_focus()
		
	else:
		$StageClear.hide()
		
	if state_game == "game_complete":
		$Congratulations.show()
		
	else:
		$Congratulations.hide()
	
	if state_game == "main_menu":
		pass



