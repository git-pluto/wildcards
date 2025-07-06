extends lerp_ease
class_name additive_lerp

# obj, property, end, ease, duration, tags, timestart

func _process(delta: float) -> void:
	if paused:
		return
	for i in active:
		var a = lerp(0, 1,i[3].call((g.t()-i[6])/i[4]))-lerp(0, 1,i[3].call((g.t()-delta-i[6])/i[4]))
		match i[1]:
			propers.scale:
				i[0].scale += a*i[2]
			propers.position:
				i[0].position += a*i[2]
			propers.rotation:
				i[0].rotation += a*i[2]
				if i[0].rotation_degrees < 0: i[0].rotation_degrees += 360
				elif i[0].rotation_degrees > 360: i[0].rotation_degrees -= 360
			propers.skew:
				i[0].skew += a*i[2]
	reading()
