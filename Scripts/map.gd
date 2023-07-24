extends Node2D

var camera:Camera2D = null
var enemy:CharacterBody2D = null
func _ready():
	camera = $"Player/Camera2D" # 假设相机为子节点且名为"Camera2D"
	GlobalSignals.game_over.connect(game_over)

func spawn_enemy():
	enemy = load("res://Sences/s_enemy.tscn").instantiate()
	
	enemy.speed = randon_value(100,500,3)
	
	add_child(enemy)
	randon_spawn_position()
	

func randon_spawn_position():
	var screen_size:Vector2 = camera.get_viewport_rect().size
	var spawn_position:Vector2
	var top_left:Vector2 = Vector2(camera.get_screen_center_position().x-screen_size.x/2,camera.get_screen_center_position().y-screen_size.y/2)
	var bottom_right:Vector2 = Vector2(camera.get_screen_center_position().x+screen_size.x/2,camera.get_screen_center_position().y+screen_size.y/2)
	var random_side:int = randi() % 4
	
	if random_side == 0:#顶部
		spawn_position = Vector2(randf_range(top_left.x,bottom_right.x),top_left.y)
	if random_side == 1:#底部
		spawn_position = Vector2(randf_range(top_left.x,bottom_right.x),bottom_right.y)
	if random_side == 2:#左边
		spawn_position = Vector2(top_left.x,randf_range(top_left.y,bottom_right.y))
	if random_side == 3:#右边
		spawn_position = Vector2(bottom_right.x,randf_range(top_left.y,bottom_right.y))
	
	enemy.global_position = spawn_position
	
func randon_value(min_value:float,max_value:float,exponent:int):
	var value:float
	var range_value = max_value-min_value
	var k = randf()**exponent
	value = min_value + range_value*k
	return value

func new_game():
	$Spawn.start()
	$HUD/Score.score = 0
	$HUD/Score.visible=true
	$HUD/Score.set_text("score:0")
	$HUD/Message.hide()

func _on_spawn_timeout() -> void:
	spawn_enemy()


func _on_start_pressed() -> void:
	$HUD/Start.hide()
	new_game()

func game_over():
	
	$Spawn.stop()
	$MessageTimer.start()
	$HUD/Message.visible=true
	$HUD/Message.set_text("Game Over")
func _on_message_timer_timeout() -> void:
	$HUD/Message.set_text($HUD/Score.text)
	$HUD/Score.hide()
	$HUD/Start.visible=true
	
	
