extends lerp_ease
class_name additive_lerp

func _process(delta: float) -> void:
	var a = lerp(0, 1,eas.call((g.t()-timestart)/duration))-lerp(0, 1,eas.call((g.t()-delta-timestart)/duration))
	
	match property:
		propers.scale:
			obj.scale += a*end
		propers.position:
			obj.position += a*end
		propers.rotation:
			obj.rotation += a*end
			if obj.rotation_degrees < 0:
				obj.rotation_degrees += 360
			elif obj.rotation_degrees > 360:
				obj.rotation_degrees -= 360
	
	reading()
