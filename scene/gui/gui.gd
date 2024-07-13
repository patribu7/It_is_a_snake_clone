extends Control

var _box_panel = preload("res://scene/gui/box_panel.tscn")

func toggle_menu(state):
	$Menu.state_game = state
	$Menu.visible = !$Menu.visible


func hide_menu():
	$Menu.hide()


func open_desc_senario():
	var box_panel = _box_panel.instantiate()
	box_panel.is_in_scenario = true
	box_panel.add_context("text_box")
	box_panel.set_back_btn_text("OK")

	get_node("Menu").add_child(box_panel)
	
	return box_panel
