extends lerp_ease
class_name iterative_lerp

# obj, property, end, ease, duration, tags, timestart

func _process(delta: float) -> void:
	for i in active:
		var a = lerp(float(1), float(i[2]),i[3].call((g.t()-i[6])/i[4]))/lerp(float(1), float(i[2]),i[3].call((g.t()-delta-i[6])/i[4]))
		match i[1]:
			propers.scale:
				i[0].scale *= a
			propers.position:
				i[0].position *= a
			propers.rotation:
				i[0].rotation *= a
	reading()
