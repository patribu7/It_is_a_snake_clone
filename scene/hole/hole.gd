extends "res://scene/cell_block/block.gd"

var teleport_pos

func _ready():
	teleport_pos = $Teleport_pos.position
