extends Node

signal change_level

var record_on_endless = 0
var unlocked_levels = 1

var apple_score = 0:
	set(value):
		apple_score = value
		print("apple score: ", apple_score)
		if is_instance_valid(counter_score):
			update_HUD_score(value)

var current_level: int:
	set(value):
		current_level = value
		change_level.emit()

var description = {
	"header": "no text",
	"body": "no text",
	"goal": "no text"
}
		

@onready var counter_score = get_node("/root/Main/GUI/HUD/Score/Counter")

func _ready():
	change_level.connect(_on_change_level)


func _on_change_level():
	#get description of that level
	var file = FileAccess.open("res://scenarios/description/desc%s.txt" % current_level, FileAccess.READ)
	var text = file.get_as_text()
	
	#get header
	description["header"] = text.get_slice("---", 0)
	
	#get body
	description["body"] = text.get_slice("---", 1)

	#get goal
	description["goal"] = text.get_slice("---", 2)
	get_node("/root/Main/GUI/Menu/MenuPaused/Goal/Goal_label").text = description["goal"]
	
	file.close()


func get_credits_text():
	var file = FileAccess.open("res://credits/credits.txt", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content
	
	
func update_HUD_score(i:int):
	counter_score.text = str(i)


func set_record():
	if apple_score > record_on_endless:
		record_on_endless = apple_score


func check_for_unlocked_levels(lv):
	current_level = lv
	if current_level > unlocked_levels:
		unlocked_levels = current_level
