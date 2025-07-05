extends Node2D

var stuff = []

func _ready() -> void:
	await ready
	var a = sprite("firefly")
	sc.translate(a, Vector3(0,0,100))
	var lep:additive_lerp = calc.setLerp("add")
	lep.wadd(a,"scale",Vector2(0,2),calc.jump,1,["loop head"])
	lep.wadd(a,"scale",Vector2(2,0),calc.jump,1,["loop tail",2, "parallel"])
	lep.start()

func movecamera(vec):
	for i in stuff:
		var a:space_lerp = calc.setLerp("spc")
		a.add(i,"translation",vec,calc.hio,1,[])

func spincamera(vec):
	for i in stuff:
		var a:space_lerp = calc.setLerp("spc")
		a.add(i,"orbit",vec,calc.hio,1,[])

func sprite(Xname):
	var a:Sprite2D = Sprite2D.new()
	add_child(a)
	a.texture = load("res://critter sprites/"+Xname+".png")
	a.set_script(load("res://user interface/display object.gd"))
	stuff.append(a)
	a.pos.z+=5
	a.scale*=100
	return a
