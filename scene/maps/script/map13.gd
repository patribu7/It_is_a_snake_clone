extends "res://scene/maps/script/game_map.gd"

var triggers = {
	"FallingObj" : "fall_objs",
	"ChoosingWay1" : "reveal_obstacle",
	"TurnBack" : "change_text_turn_back"
}

func _ready():
	$Snake/Player.vector_min = Vector2(0, -10000)
	
	#apple score reset
	GameData.apple_score = 0
	
	#connect Snake
	if has_node("Snake"):
		var snake = get_node("Snake")
		snake.get_node("Player").snake_eat.connect(_on_snake_eat)
		snake.get_node("Player").snake_be_defeat.connect(_on_snake_be_defeat)
		snake.get_node("Player").snake_win.connect(_on_snake_win)


func _on_timer_timeout():
	$Snake._on_timer_timeout()
	teleport()
	detect_trigger()
	move_cam() #issue fintanto che non e' child di Player, cam non si muove da sola, me se lo fosse si muoverebbe ancche dx e sx


func move_cam():
	$Snake/Cam.global_position.y = $Snake/Player.global_position.y - 10 * Global.tile_size.y


func teleport():
	for point in $Teleports.get_children():
		if $Snake/Player.global_position == point.global_position:
			$Snake/Player.global_position = point.get_node("Out").global_position


func detect_trigger():
	for trigger in $Triggers.get_children():
		if $Snake/Player.global_position.y == trigger.global_position.y:
			self.call(triggers[trigger.name])


func fall_objs():
	print("start animation")
	for obj in $FallingObj.get_children():
		await Global.wait(obj.get_meta("timing_to_fall"))
		_move_obj(obj)

func _move_obj(obj):
	while obj.global_position.y < $Snake/Cam.global_position.y + 700:
		obj.position.y += 10
		await Global.wait(0.04)

	if obj.type_obj == "spider":
		var i = 0
		while i < 10: #issue vabbe' sarebbe meglio rimettere la posizine iniziale...
			obj.position.y -= 50
			await Global.wait(0.04)
			i += 1


func reveal_obstacle():
	pass #issue pass
	
func change_text_turn_back():
	$Texts/Label5.text = "Tornando sui tuoi passi"
	
	
func handler_time():
	pass
	
func _on_snake_be_defeat(): #considero questo livello come saluto. Non voglio che si debba ricaricarlo da capo
	await Global.wait(3)
	$Snake/Player/Sprite.play("default")
	#aspetta 3 secondi e rimetti lo sprite default della testa 


func _on_snake_win():
	play_cutscene()
	

func play_cutscene():
	pass
	
