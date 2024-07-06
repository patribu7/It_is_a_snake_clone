extends RichTextLabel

signal title_pass

var any_key_is_pressed_yet = false

func _input(event):
	if not any_key_is_pressed_yet and event.is_pressed():
		not_that_key()
	
	if any_key_is_pressed_yet and event.is_action_released("Space"):
		#go to main menu
		print("GO TO MAIN MENU")
		title_pass.emit()
		
	if event.is_action_pressed("dev_skip"):
		title_pass.emit()
		

func not_that_key():
	text = "No! Not that key!... argh!\nJust...just press...\nWait a second let me fix some issue..."
	await Global.wait(5)
	text = "OK, let's press space...\nJust... SPACE"
	any_key_is_pressed_yet = true
