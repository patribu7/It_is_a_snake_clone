extends Area2D

@export var size = Vector2(50, 50)
@export_enum("eat", "be_defeat", "win", "be_teleported") var snake_can: String
@export var score_handler = 0

@export_enum("apple", "spider") var type_obj = ""

func _ready():
	size = Global.tile_size


func take_position(pos):
	global_position = pos
		
		
