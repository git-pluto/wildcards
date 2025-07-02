extends Node
class_name lerp_ease

var timestart: float
var obj: Node2D
var duration
var end
var eas
var property
var queue:Array[Array] = []
enum propers {
	position, scale, rotation
}

signal step
signal finish

func _process(delta: float) -> void:
	var a = lerp(float(1), float(end),eas.call((g.t()-timestart)/duration))/lerp(float(1), float(end),eas.call((g.t()-delta-timestart)/duration))
	match property:
		propers.scale:
			obj.scale *= a
		propers.position:
			obj.position *= a
		propers.rotation:
			obj.rotation *= a
	reading()

func reading():
	if g.t()-timestart >= duration:
		if len(queue):
			setup(queue.pop_front())
			step.emit()
		else:
			finish.emit()
			queue_free()

func add(xObj, xProperty, xEnd, xEase, xDuration):
	if not obj:
		setup([xObj, xProperty, xEnd, xEase, xDuration])
	else:
		queue.append([xObj, xProperty, xEnd, xEase, xDuration])

func setup(arr: Array):
	obj = arr[0]
	match arr[1]:
		"position":
			property = propers.position
		"rotation":
			property = propers.rotation
		"scale": 
			property = propers.scale
		"rotation_degrees":
			property = propers.rotation
			arr[2]*=PI/180
		_:
			print("invalid property")
	end = arr[2]
	eas = arr[3]
	duration = arr[4]
	timestart = g.t()
