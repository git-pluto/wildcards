extends Node2D
const DISPLAY_OBJECT = preload("res://user interface/display_object.tscn")

var stuff = []

var matrix: Array[Array] = [[],[],[],[]]

var names = ["bullfrog",
"cheerleader crab",
"decorator crab",
"firefly",
"giant snail",
"Lyrebird",
"nautilus",
"pearl oyster",
"silverfish"]

var lipepa:iterative_lerp

var objectinfocus

#(-30.0, 0.0, 105.0)

func _ready() -> void:
	await ready
	
	var slope = 30
	# tilt of 50x per 150y
	for i in 5:
		quicksprite(names.pick_random(),Vector3((i*80)+80,slope*-2,400+i*20),4)
	for i in 5:
		quicksprite(names.pick_random(),Vector3((i*80)+30,slope*-1,250+i*20),3)
	for i in 5:
		var a = quicksprite(names.pick_random(),Vector3((i*80)-20,0,100+i*20),2)
		a.scale.x*=-1
	for i in 5:
		var a = quicksprite(names.pick_random(),Vector3((i*80)-70,slope,-50+i*20),1)
		a.scale.x*=-1
	
	objectinfocus = matrix[1][0]
	
	
	#lipepa = calc.setLerp("ite")
	#lipepa.add(matrix[0][0],"scale",Vector2(2,2),calc.jump,0.5,["loop head", "loop tail", -1])

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
		a.add(i,"orbit",vec,calc.co,1,[])

func sprite(Xname):
	var a:Display_obj = DISPLAY_OBJECT.instantiate()
	add_child(a)
	a.spriteset(Xname)
	a.sprite.position += values.get_sprite_offset(Xname)
	a.pivot.position += values.get_pivot_offset(Xname)
	stuff.append(a)
	a.pos.z+=5
	a.scale*=100
	return a

func quicksprite(Xname, Xpos, row):
	var a = sprite(Xname)
	sc.translate(a, Xpos)
	match row:
		4:
			var b = back(matrix[3])
			if b:
				a.left = b
				b.right = a
			matrix[3].append(a)
		3:
			var b = back(matrix[2])
			if b:
				a.left = b
				b.right = a
			a.front = matrix[3][len(matrix[2])]
			matrix[3][len(matrix[2])].back = a
			matrix[2].append(a)
		2:
			var b = back(matrix[1])
			if b:
				a.left = b
				b.right = a
			a.front = matrix[2][len(matrix[1])]
			matrix[2][len(matrix[1])].back = a
			matrix[1].append(a)
		1:
			var b = back(matrix[0])
			if b:
				a.left = b
				b.right = a
			a.front = matrix[1][len(matrix[0])]
			matrix[1][len(matrix[0])].back = a
			matrix[0].append(a)
		_:
			print("somethings wrong")
	
	
	var lep = calc.setLerp("add")
	var lap = calc.setLerp("ite")
	lep.add(a.pivot,"skew",2*PI/180,calc.jump,1,["loop head"])
	lep.add(a.pivot,"skew",-2*PI/180,calc.jump,1,["loop tail",-1])
	lap.add(a.pivot,"scale",Vector2(1,0.9),calc.sqi,0.5,["loop head"])
	lap.add(a.pivot,"scale",Vector2(1,1/0.9),calc.sqo,0.5,["loop tail",-1])
	return a

func back(arr: Array):
	if len(arr) == 0:
		return null
	return arr.back()
