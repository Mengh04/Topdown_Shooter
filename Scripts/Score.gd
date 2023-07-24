extends Label
var score:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.enemy_dead.connect(update_score)


func update_score():
	score+=1
	set_text("score:" +str(score))
