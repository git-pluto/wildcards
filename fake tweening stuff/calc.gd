extends Node

const AdditiveLerp = preload("res://fake tweening stuff/additive_lerp.gd")
const IterativeLerp = preload("res://fake tweening stuff/iterative_lerp.gd")
const SpaceLerp = preload("res://fake 3d stuff/space_lerp.gd")
const CameraLerp = preload("res://fake 3d stuff/camera_lerp.gd")

func setLerp(type: String):
	var a = Node.new()
	match type:
		"ite":
			a.set_script(IterativeLerp)
		"add":
			a.set_script(AdditiveLerp)
		"spc":
			a.set_script(SpaceLerp)
		"cam":
			a.set_script(CameraLerp)
	add_child(a)
	return a

func li(a: float): # funcao linear
	a = clamp(a,0,1)
	return a

func ci(a: float): # funcao circular ease in
	a = clamp(a,0,1)
	return (1-(1-a**2)**0.5)

func co(a: float): # funcao circular ease out
	a = clamp(a,0,1)
	return ((1-(a-1)**2)**0.5)

func sqi(a: float): # funcao quadratica ease in
	a = clamp(a,0,1)
	return a**2

func sqo(a: float): # funcao quadratica ease out
	a = clamp(a,0,1)
	return 1-(a-1)**2

func hio(a: float): # funcao harmonica ease in out
	a = clamp(a,0,1)
	return 1-((cos(a*PI))/(2))-0.5

func hoi(a: float): # funcao harmonica ease out in
	a = clamp(a,0,1)
	return acos(2-(2*a+1))/PI

func jump(a: float): # funcao harmonica que termina onde comecou
	a = clamp(a,0,1)
	return abs(sin(a*PI))

func twoci(a: float): # funcao duplo circular ease in
	a = clamp(a,0,1)
	return ci(ci(a))

func twoco(a: float): # funcao duplo circular ease out
	a = clamp(a,0,1)
	return co(co(a))

#func sen(a: float, eas):
	#a = clamp(a,0,1)
	#if eas == "inout":
		#return 1-((cos(a*PI))/(2))-0.5
	#if eas == "outin":
		#return acos(2-(2*a+1))/PI
#func squ(a: float, eas):
	#a = clamp(a,0,1)
	#if eas == "in":
		#return a**2
	#if eas == "out":
		#return 1-(a-1)**2
#func circ(a: float, eas): # recebe um numero entre 0 e 1 e retorna o numero em uma função circular crescente com ease in
	#a = clamp(a,0,1)
	#if eas == "in":
		#return (1-(1-a**2)**0.5)
	#if eas == "out":
		#return ((1-(a-1)**2)**0.5)
