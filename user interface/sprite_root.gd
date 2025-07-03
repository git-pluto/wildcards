extends Node2D

var stuff = []

func movecamera(vec):
	for i in stuff:
		var a:space_lerp = calc.setLerp("spc")
		a.add(i,"translation",vec,calc.hio,1,[])

func spincamera(vec):
	for i in stuff:
		var a:space_lerp = calc.setLerp("spc")
		a.add(i,"orbit",vec,calc.hio,1,[])

func sprite(ame):
	var a:Sprite2D = Sprite2D.new()
	add_child(a)
	a.texture = load("res://sprites/"+ame+".png")
	a.set_script(load("res://icon.gd"))
	stuff.append(a)
	a.pos.z+=10
	a.scale*=100
	return a
