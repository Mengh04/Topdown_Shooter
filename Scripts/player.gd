extends CharacterBody2D


@export var speed:float = 300.0

func _physics_process(delta) -> void:


	var x := Input.get_axis("left", "right")
	var y := Input.get_axis("up","down")
	velocity = Vector2(x,y).normalized()*speed
	
	if velocity:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = (velocity.x < 0)
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()
	var collision := get_last_slide_collision()
	if collision:
		if collision.get_collider().is_in_group("enemies"):
			GlobalSignals.game_over.emit()
