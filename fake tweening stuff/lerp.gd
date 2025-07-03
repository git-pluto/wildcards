extends Node
class_name lerp_ease

# obj, property, end, ease, duration, tags, timestart
var active:Array[Array] = []
#var timestart: float
#var obj: Node2D
#var duration
#var end
#var eas
#var property
var queue:Array[Array] = []
enum propers {
	position, scale, rotation
}

signal step
signal finish

func _process(_delta: float) -> void:
	pass

func reading():
	for i in active:
		if g.t()-i[6] >= i[4]:
			active.erase(i)
	if not len(active):
		if len(queue):
			setup(queue.pop_front())
			step.emit()
		else:
			finish.emit()
			queue_free()

func add(xObj, xProperty, xEnd, xEase, xDuration, Tags):
	if not active[0]:
		setup([xObj, xProperty, xEnd, xEase, xDuration, Tags])
	else:
		queue.append([xObj, xProperty, xEnd, xEase, xDuration, Tags])

func setup(arr: Array):
	match arr[1]:
		"position":
			arr[1] = propers.position
		"rotation":
			arr[1] = propers.rotation
		"scale": 
			arr[1] = propers.scale
		"rotation_degrees":
			arr[1] = propers.rotation
			arr[2]*=PI/180
		_:
			print("invalid property")
	arr[6] = g.t()
	active.append(arr)
	if len(queue):
		if queue.front()[5].has("parallel"):
			setup(queue.pop_front())

func kill():
	finish.emit()
	queue_free()
