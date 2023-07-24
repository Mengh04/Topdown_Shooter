extends CharacterBody2D



@onready var player = $"/root/Map/Player"
@export var speed:float = 100.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.game_over.connect(game_over)

func _physics_process(delta: float) -> void:
	var direction:Vector2 = player.global_position - global_position
	velocity = direction.normalized()*speed
	
	if velocity:
		$AnimatedSprite2D.play("move")
		$AnimatedSprite2D.flip_h = (velocity.x < 0)
	
	move_and_slide()
	
func dead():
	$AnimatedSprite2D.play("dead")
	$dead.play()
	GlobalSignals.enemy_dead.emit()
	set_physics_process(false)
	set_collision_layer_value(1,false)
	$DeadAnimation.start()
	await $DeadAnimation.timeout
	queue_free()
	
func game_over():
	queue_free()
	
