extends "res://scene/maps/script/game_map.gd"

signal continue_

var is_in_closing_credits = false

var triggers = {
	"FallingObj" : "fall_objs",
	"TurnBack" : "change_text_turn_back",
	"LookingBack" : "play_old_snake",
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
	if not $Snake/Player == null:
		if $Snake/Player.global_position.y < $Markers/TheEdgeOFSheet1.global_position.y and $Snake/Player.global_position.y > $Markers/TheEdgeOFSheet2.global_position.y:
			$Snake/Cam.global_position.y = $Snake/Player.global_position.y - 10 * Global.tile_size.y
			get_parent().get_parent().get_node("GUI").position.y = $Snake/Player.global_position.y - 10 * Global.tile_size.y
	
	else:
		pass #issue volevo usare questo per l'animazione deti titili di coda...
	

func teleport():
	for point in $Teleports.get_children():
		if $Snake/Player.global_position == point.global_position:
			$Snake/Player.global_position = point.get_node("Out").global_position


func detect_trigger():
	for trigger in $Triggers.get_children():
		
		if $Snake/Player.global_position.y == trigger.global_position.y:
			self.call(triggers[trigger.name])


func fall_objs():
	for obj in $Animations/FallingObj.get_children():
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
	$Animations/Woodpecker.frame = 1
	
	
func change_text_turn_back():
	$Texts/Label5.text = "Tornando sui tuoi passi"


func play_old_snake():
	$Animations/Player.play("old_snake")
	
	
func handler_time():
	pass #do not change time


func  reveal_text_errors():
	$Texts/Label5bis.show()


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
	if $Snake/Player.global_position == $Markers/ChoosingWay.global_position:
		reveal_obstacle()
	
	if $Snake/Player.global_position.y >= $Markers/Errors1.global_position.y and $Snake/Player.global_position.y <= $Markers/Errors2.global_position.y and $Snake/Player.global_position.x == $Markers/Errors2.global_position.x:
		reveal_text_errors()
	
	
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
	var anim = $Animations/Player
	
	anim.play("cutscene1")
	await anim.animation_finished
	await continue_
	
	anim.play("cutscene2")
	await anim.animation_finished
	await continue_
	
	anim.play("cutscene3")
	await anim.animation_finished
	go_to_closing_credits()


func _input(event):
	if event.is_action_pressed("ui_accept"):
		self.continue_.emit()
	
	if event.is_action_pressed("pause") and is_in_closing_credits:
		get_parent().get_parent().get_node("GUI").hide()


func go_to_closing_credits():
	is_in_closing_credits = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	$Animations/ClosingCredits.show() #issue questo sarebbe da farlo con transazione
	$Texts.hide()
	$Animations/Player.play("closing_credits")
	
	await $Animations/Player.animation_finished
	await Global.wait(5)
	go_to_main_menu()
	
func go_to_main_menu():
	get_parent().stage_clear.emit()
	get_parent().get_parent().get_node("GUI").position.y = 0
	queue_free()

