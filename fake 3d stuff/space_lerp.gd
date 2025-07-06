extends lerp_ease
class_name space_lerp

# obj, property, end, ease, duration, tags, timestart

func _process(delta: float) -> void:
	if paused:
		return
	for i in active:
		var a = lerp(0, 1,i[3].call((g.t()-i[6])/i[4]))-lerp(0, 1,i[3].call((g.t()-delta-i[6])/i[4]))
		match i[1]:
			0: sc.translate(i[0],a*i[2])
			2: sc.orbit(i[0],a*i[2])
	reading()

func setup(arr: Array):
	match arr[1]:
		"translation":
			arr[1] = propers.position
		"orbit":
			arr[1] = propers.rotation
		"orbit_degrees":
			arr[1] = propers.rotation
			arr[2]*=PI/180
		_:
			print("invalid property")
	arr[6] = g.t()
	active.append(arr)
	if len(queue):
		if queue.front()[5].has("parallel"):
			setup(queue.pop_front())
