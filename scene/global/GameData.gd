extends Node

var record_on_endless = 0
var unlocked_levels = 1

var apple_score = 0:
	set(value):
		apple_score = value
		update_HUD_score(value)
		print("apple score: ", apple_score)

var current_level: int:
	set(value):
		current_level = value
		load_desc_scene(value)

var description = {
	"header": "text not find ç_ç",
	"body": "text not find ç_ç",
	"goal": "text not find ç_ç"
}

@onready var counter_score = get_node("/root/Main/GUI/HUD/Score/Counter")
@onready var alert_box = get_node("/root/Main/GUI/HUD/Alert")


func load_desc_scene(lv):
	#get description of that level
	var file = FileAccess.open("res://scenarios/description/desc%s.txt" % lv, FileAccess.READ)
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


func check_for_unlocked_levels(lv):
	current_level = lv
	if current_level > unlocked_levels:
		unlocked_levels = current_level
	
	
func set_record():
	if apple_score > record_on_endless:
		record_on_endless = apple_score


func update_HUD_score(i:int):
	if is_instance_valid(counter_score):
		counter_score.text = str(i)


func show_alert(t: String):
	if is_instance_valid(alert_box):
		alert_box.text = t
		await Global.wait(3)
		alert_box.text = ""
