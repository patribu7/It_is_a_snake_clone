extends "res://scene/cell_block/block.gd"

var apples_to_open_gate = 0

func _ready():
	snake_can = "be_defeat"
	
	
func open():
	snake_can = "pass_through"
	$Sprite.play("open")
	GameData.show_alert("THE GATE IS OPEN!")
	
