extends lerp_ease
class_name additive_lerp

# obj, property, end, ease, duration, tags, timestart, compensator

func _process(delta: float) -> void:
	if paused:
		return
	super(delta)
	for i in active:
		var a = lerp(0, 1,i[3].call((g.t()-i[6])/i[4]))-lerp(0, 1,i[3].call((g.t()-i[6]-delta)/(i[4])))
		i[7] += a*i[2]
		match i[1]:
			propers.scale:
				i[0].scale += a*i[2]
			propers.position:
				i[0].position += a*i[2]
			propers.rotation:
				i[0].rotation += a*i[2]
				if i[0].rotation_degrees < 0:i[0].rotation_degrees += 360
				elif i[0].rotation_degrees > 360: i[0].rotation_degrees -= 360
			propers.skew:
				i[0].skew += a*i[2]
	reading()

# i have to increase the duration and adjust for timestart

func set_compensator(end):
	if typeof(end) == 2 or typeof(end) == 3:
		return 0.0
	if typeof(end) == 5:
		return Vector2(0,0)

func compensate(i):
	var c
	match i[3]:
		calc.jump:
			c = -i[7]
		_:
			c = i[2]-i[7]
	match i[1]:
			propers.scale:
				i[0].scale += c
			propers.position:
				i[0].position += c
			propers.rotation:
				i[0].rotation += c
				if i[0].rotation_degrees < 0:i[0].rotation_degrees += 360
				elif i[0].rotation_degrees > 360: i[0].rotation_degrees -= 360
			propers.skew:
				i[0].skew += c
