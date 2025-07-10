extends lerp_ease
class_name space_lerp

# obj, property, end, ease, duration, tags, timestart, compensator

func _process(delta: float) -> void:
	if paused:
		return
	super(delta)
	for i in active:
		var a = lerp(0, 1,i[3].call((g.t()-i[6])/i[4]))-lerp(0, 1,i[3].call((g.t()-delta-i[6])/i[4]))
		i[7] += a*i[2]
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
	arr.append(g.t())
	arr.append(set_compensator(arr[2]))
	active.append(arr)
	if len(queue):
		if queue.front()[5].has("parallel"):
			setup(queue.pop_front())

func compensate(i):
	var c
	match i[3]:
		calc.jump:
			c = -i[7]
		_:
			c = i[2]-i[7]
	match i[1]:
			0: sc.translate(i[0],c)
			2: sc.orbit(i[0],c)

func set_compensator(end):
	if typeof(end) == 5:
		return Vector2(0,0)
	if typeof(end) == 9:
		return Vector3(0,0,0)
