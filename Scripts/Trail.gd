extends Line2D

@export var pointCount:int = 20

var parentGlobalPositions:Array = []


func _ready() -> void:
	clear_points()
	
func _process(delta: float) -> void:
	global_rotation = 0
	get_parent_global_positions()
	update_point()
	
	
func get_parent_global_positions():
	#if parentGlobalPositions.size()==0:
	parentGlobalPositions.push_back(get_parent().global_position)
	#elif parentGlobalPositions.size()>0 and get_parent().global_position != parentGlobalPositions[-1]:
		#parentGlobalPositions.push_back(get_parent().global_position)
	if parentGlobalPositions.size() > pointCount:
		parentGlobalPositions.pop_front()

func update_point():
	if get_point_count() < pointCount:
		add_point(Vector2(0,0))
	for i in range(parentGlobalPositions.size()):
		if i == 0:
			points[i] = Vector2(0,0)
		elif i > 0:
			points[i] = (parentGlobalPositions[i-1] - parentGlobalPositions[i])+points[i-1]
		print(parentGlobalPositions[i-1] - parentGlobalPositions[i])
