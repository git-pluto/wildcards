extends lerp_ease
class_name space_lerp

func _process(delta: float) -> void:
	var a = lerp(0, 1,eas.call((g.t()-timestart)/duration))-lerp(0, 1,eas.call((g.t()-delta-timestart)/duration))
	match property:
		0: sc.translate(obj,a*end)
		1: sc.orbit(obj,a*end)
	reading()

func setup(arr: Array):
	obj = arr[0]
	match arr[1]:
		"translation":
			property = 0
		"orbit":
			property = 1
		_:
			print("invalid property")
	end = arr[2]
	eas = arr[3]
	duration = arr[4]
	timestart = g.t()
