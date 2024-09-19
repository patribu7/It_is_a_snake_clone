extends Node

signal request_main_menu

var any_key_is_pressed_yet = false
var animation_is_finished = false

func _ready():
	await $AnimationPlayer.animation_finished
	animation_is_finished = true

func go_to_main_menu():
	request_main_menu.emit()
	print("GO TO MAIN MENU")
	queue_free()


func _unhandled_input(event): #avrei potuto farlo tutto con l'animazione...
	if event.is_pressed():
		
		if GameData.is_first_access:
			
			if not any_key_is_pressed_yet and animation_is_finished:
				not_that_key()
			
			if any_key_is_pressed_yet and event.is_action_pressed("Space"):
				go_to_main_menu()
		
		else:
			go_to_main_menu()
	

func not_that_key():
	$PanelDx/Annunce_DEMO.hide()
	$PanelDx/This_symbol.hide()
	
	$AnimationPlayer/Sounds.play()
	$PanelDx/Press_any_key.text = "No! Not that key!... argh!\nJust...just press...\nWait a second let me fix some issue..."
	await Global.wait(5)
	
	$AnimationPlayer/Sounds.play()
	$PanelDx/Press_any_key.text = "OK, let's press space...\nJust... SPACE"
	any_key_is_pressed_yet = true
