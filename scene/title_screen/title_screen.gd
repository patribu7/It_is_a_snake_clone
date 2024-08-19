extends Node

signal request_main_menu

var any_key_is_pressed_yet = false
var animation_is_finished = false

func _ready():
	await $AnimationPlayer.animation_finished
	animation_is_finished = true

func go_to_main_menu():
	queue_free()
	request_main_menu.emit()


func _input(event):
	if not any_key_is_pressed_yet and animation_is_finished and event.is_pressed():
		not_that_key()
	
	if any_key_is_pressed_yet and event.is_action_released("Space"):
		#go to main menu
		print("GO TO MAIN MENU")
		go_to_main_menu()
		
	if event.is_action_pressed("dev_skip"):
		print("SKIP")
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
