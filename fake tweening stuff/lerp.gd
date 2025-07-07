extends Node
class_name lerp_ease

# obj, property, end, ease, duration, tags, timestart
var active:Array[Array] = []

var offtime = 0

#var timestart: float
#var obj: Node2D
#var duration
#var end
#var eas
#var property

var timescaler = 1

var paused = false

var queue:Array[Array] = []
enum propers {
	position, scale, rotation, skew
}

var count = 0

signal step
signal finish

func _process(_delta: float) -> void:
	pass

func reading():
	for i in active:
		if g.t()-i[6] >= i[4]:
			active.erase(i)
	if not len(active):
		if queue.get(count)[5].has("loop tail"):
			var a = queue.get(count)[5].find("loop tail")+1 # a is just the index of the number
			if queue[count][5].get(a) > 0:
				queue[count][5][a]-=1
			if not queue[count][5].get(a) == 0:
				while true:
					if queue.get(count)[5].has("loop head"):
						break
					count-=1
					assert(count >= 0, "Lerp ease Looping found no loop head")
			else: count+=1
		else: count+=1
		if count < len(queue):
			setup(queue.get(count).duplicate())
			step.emit()
		else:
			finish.emit()
			queue_free()

func add(xObj, xProperty, xEnd, xEase, xDuration, Tags):
	if not len(active):
		setup([xObj, xProperty, xEnd, xEase, xDuration, Tags])
	queue.append([xObj, xProperty, xEnd, xEase, xDuration, Tags])

func wadd(xObj, xProperty, xEnd, xEase, xDuration, Tags): # wadd is "wait add", for when you dont want the lerping to start
	queue.append([xObj, xProperty, xEnd, xEase, xDuration, Tags]) # automatically with the add.

func start():
	if not len(active):
		setup(queue[0].duplicate())

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
		"skew":
			arr[1] = propers.skew
		"skew_degrees":
			arr[1] = propers.skew
			arr[2]*=PI/180
		_:
			print("invalid property")
	arr.append(g.t())
	arr[4]/=timescaler
	active.append(arr)
	if count+1 < len(queue):
		if queue.get(count+1)[5].has("parallel"):
			count+=1
			
			setup(queue.get(count).duplicate())

func kill():
	finish.emit()
	queue_free()

func pause_toggle():
	if paused:
		unpause()
	else: pause()

func pause():
	paused = true
	offtime = g.t()

func unpause():
	for i in active:
		i[6]+= g.t() - offtime
	paused = false

func timescale(x:float):
	for i in active:
		var progress = (g.t()-i[6])/i[4]
		i[6]-= (progress/x)-progress # hm... the equasions still give wrong results. how??
		i[4]/=x
	timescaler*=x
