extends CharacterBody2D

@export var speed:float = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = Vector2.RIGHT.rotated(rotation)*speed
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.get_collider().has_method("dead"):
			collision.get_collider().dead()
		queue_free()



func _on_destroy_timeout() -> void:
	queue_free()
