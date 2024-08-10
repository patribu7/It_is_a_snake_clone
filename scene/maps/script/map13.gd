extends "res://scene/maps/script/game_map.gd"

var cam_is_not_on_border = true

var triggers = {
	"FallingObj" : "fall_objs",
	"ChoosingWay1" : "reveal_obstacle",
	"TurnBack" : "change_text_turn_back",
	"LookingBack" : "play_old_snake",
	"TheEdgeOFCam1" : "toggle_stop_cam",
	"TheEdgeOFCam2" : "toggle_stop_cam"
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
	move_cam() #issue fintanto che non e' child di Player, cam non si muove da sola, me se lo fosse si muoverebbe ancche dx e sx
	detect_trigger()


func move_cam():
	if cam_is_not_on_border:
		$Snake/Cam.global_position.y = $Snake/Player.global_position.y - 10 * Global.tile_size.y


func teleport():
	for point in $Teleports.get_children():
		if $Snake/Player.global_position == point.global_position:
			$Snake/Player.global_position = point.get_node("Out").global_position


func detect_trigger():
	for trigger in $Triggers.get_children():
		if $Snake/Player.global_position.y == trigger.global_position.y:
			self.call(triggers[trigger.name])


func toggle_stop_cam():
	cam_is_not_on_border = !cam_is_not_on_border
	

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


func play_old_snake():
	$VisualElements/OldSnake.play("default")

	
func handler_time():
	pass


func animation_level_clear():
	$Timer.stop()
	$Snake/Player.hide()
	var wag_tail = 0

	var t = $Snake/Tail_queue.get_child_count()
	var i = 1
	while i < t:
		await Global.wait($Timer.get_wait_time())
		var tail_block = $Snake/Tail_queue.get_child(-1)
		tail_block.free()
		$Snake/Tail_queue.get_child(-1).set_sprite_last_tail(wag_tail)
		wag_tail = (wag_tail + 1) % 2
		i += 1
		

	
func _on_snake_be_defeat(): #considero questo livello come saluto. Non voglio che si debba ricaricarlo da capo
	await Global.wait(3)
	$Snake/Player/Sprite.play("default")
	#aspetta 3 secondi e rimetti lo sprite default della testa 


func _on_snake_win():
	await animation_level_clear()
	await Global.wait($Timer.get_wait_time())
	$Snake/Player.queue_free()
	$Snake/Tail_queue.queue_free()
	
	play_cutscene()
	

func play_cutscene():
	$CutsceneElements/AnimationPlayer.play("animation")
	
