extends lerp_ease
class_name iterative_lerp

# obj, property, end, ease, duration, tags, timestart

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
