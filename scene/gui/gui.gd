extends Control

func toggle_menu(state):
	$Menu.state_game = state
	$Menu.visible = !$Menu.visible


func hide_menu():
	$Menu.hide()
