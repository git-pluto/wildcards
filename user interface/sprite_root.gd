extends Node2D

var stuff = []
var lep:additive_lerp 

func _ready() -> void:
	await ready
	var a = sprite("Lyrebird") # LEMBRAR DE ADICIONAR SKEW NOS LERPS PRA TER UMA ANIMAÇÃO DE SWAY
	sc.translate(a, Vector3(0,0,100))
	lep= calc.setLerp("add")
	lep.wadd(a,"skew",30*PI/180,calc.jump,1,["loop head"])
	lep.wadd(a,"skew",-30*PI/180,calc.jump,1,["loop tail",-1])
	lep.start()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		lep.pause_toggle()

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
