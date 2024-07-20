extends Node

signal start

var _new_game_panel = preload("res://scene/gui/context_boxes/new_game_panel.tscn")
var _text_panel = preload("res://scene/gui/context_boxes/text_panel.tscn")
var _level_select_panel = preload("res://scene/gui/context_boxes/level_select_panel.tscn")
var _btn = preload("res://scene/gui/btn_exp.tscn")

var is_in_scenario = false

func _ready():
	$SubMenu/Back.grab_focus()

func set_back_btn_text(t):
	get_node("SubMenu/Back").text = t
	

func _on_back_btn_up():
	if is_in_scenario:
		start.emit()
	get_parent().get_node("MainMenu/NewGame").grab_focus()
	queue_free()


func _input(event):
	if event.is_action_pressed("back"):
		_on_back_btn_up()


func add_context(context:String):
	var box
	
	if context == "text_box":
		box = _text_panel.instantiate()

		if is_in_scenario:
			box.get_node("Header").text = GameData.description["header"]
			box.get_node("Body").text = GameData.description["body"]
			
		else:
			box.get_node("Body").text = GameData.get_credits_text()
				
	if context == "new_game":
		box = _new_game_panel.instantiate()


	if context == "level_selection":
		box = _level_select_panel.instantiate()
		
		for i in 6: #issue cambiare il numero magico 6 con un dato globale
			i += 1
			var btn = _btn.instantiate()
			btn.text = str(i)
			
			if i <= GameData.unlocked_levels:
				btn.disabled = false
			else:
				btn.disabled = true
			
			box.add_child(btn)
	
	$SubMenu/Container.add_child(box)
	
	return box
