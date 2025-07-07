extends Node2D

var stuff = []

var matrix: Array[Array] = [[],[]]

var names = ["bullfrog",
"cheerleader crab",
"decorator crab",
"firefly",
"giant snail",
"Lyrebird",
"nautilus",
"pearl oyster",
"silverfish"]

var objectinfocus

#(-30.0, 0.0, 105.0)

func _ready() -> void:
	await ready
	
	
	for i in 10:
		quicksprite(names.pick_random(),Vector3((i*120)+30,0,250))
	for i in 10:
		var a = quicksprite(names.pick_random(),Vector3((i*120)-20,0,100))
		a.scale.x*=-1
	objectinfocus = stuff[10]
	
	movecamera(Vector3(0,20,0))
	spincamera(Vector2(0,-10*PI/180))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		focuson(objectinfocus.front)
	elif event.is_action_pressed("ui_left"):
		focuson(objectinfocus.left)
	elif event.is_action_pressed("ui_right"):
		focuson(objectinfocus.right)
	elif event.is_action_pressed("ui_down"):
		focuson(objectinfocus.back)

func focuson(obj):
	if obj == null: return
	movecamera(objectinfocus.pos-obj.pos)
	objectinfocus = obj

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

func quicksprite(Xname, Xpos):
	var a = sprite(Xname)
	sc.translate(a, Xpos)
	if Xpos.z == 100:
		var b = matrix[0].back()
		if b:
			a.left = b
			b.right = a
		a.front = matrix[1][len(matrix[0])]
		matrix[1][len(matrix[0])].back = a
		matrix[0].append(a)
	else:
		var b = matrix[1].back()
		if b:
			a.left = b
			b.right = a
		matrix[1].append(a)
	var lep= calc.setLerp("add")
	lep.add(a,"skew",5*PI/180,calc.jump,1,["loop head"])
	lep.add(a,"skew",-5*PI/180,calc.jump,1,["loop tail",-1])
	return a
