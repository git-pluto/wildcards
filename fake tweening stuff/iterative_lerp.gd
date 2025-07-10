extends lerp_ease
class_name iterative_lerp

# obj, property, end, ease, duration, tags, timestart, compensator

func _process(delta: float) -> void:
	if paused:
		return
	super(delta)
	for i in active:
		var a
		if i[2] is float:
			a = lerp(float(1), float(i[2]),i[3].call((g.t()-i[6])/i[4]))/lerp(float(1), float(i[2]),i[3].call((g.t()-delta-i[6])/i[4]))
		elif i[2] is Vector2:
			a = Vector2(1,1).lerp(Vector2(i[2]),i[3].call((g.t()-i[6])/i[4]))/Vector2(1,1).lerp(Vector2(i[2]),i[3].call((g.t()-delta-i[6])/i[4]))
		i[7] *= a
		match i[1]:
			propers.scale:
				i[0].scale *= a
			propers.position:
				i[0].position *= a
			propers.rotation:
				i[0].rotation *= a
			propers.skew:
				i[0].skew *= a
	reading()

func set_compensator(end):
	if typeof(end) == 2 or typeof(end) == 3:
		return 1.0
	if typeof(end) == 5:
		return Vector2(1,1)

func compensate(i):
	var c
	match i[3]:
		calc.jump:
			c = 1/i[7]
		_:
			c = i[2]/i[7]
	match i[1]:
			propers.scale:
				i[0].scale *= c
			propers.position:
				i[0].position *= c
			propers.rotation:
				i[0].rotation *= c
				if i[0].rotation_degrees < 0:i[0].rotation_degrees += 360
				elif i[0].rotation_degrees > 360: i[0].rotation_degrees -= 360
			propers.skew:
				i[0].skew *= c
