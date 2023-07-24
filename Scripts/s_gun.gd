extends Node2D

func _process(delta):
	# 获取鼠标在视口中的位置
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	var angle = atan2(direction.y, direction.x)

	rotation = angle
	$SGun.flip_v = abs(angle) > PI/2
	

func _input(event):
	if event.is_action_pressed("fire"):
		fire()

func fire():
	var bullet = load("res://Sences/s_bullet.tscn").instantiate()
	
	get_tree().get_root().add_child(bullet)
	bullet.rotation  = rotation
	bullet.position = $Fire_Point.global_position
	
	
