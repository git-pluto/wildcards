extends Node2D

var names = ["bullfrog",
"cheerleader crab",
"decorator crab",
"firefly",
"giant snail",
"Lyrebird",
"nautilus",
"pearl oyster",
"silverfish"]

var pilesize = 25

var pile = []
const CARD = preload("res://user interface/card.tscn")
var timescale = 0.75
@onready var admin: Node = $".."

var swaylerps = []

func _ready() -> void:
	await ready
	await get_tree().create_timer(0.2).timeout
	generate()
	dosway()
	await get_tree().create_timer(0.05*pilesize+0.7).timeout
	var a = func():
		for i in 5:
			admin.draw()
			await get_tree().create_timer(0.2).timeout
	a.call()
	var lep:additive_lerp = calc.setLerp("add")
	lep.wadd(self,"position",Vector2(900,0),calc.ci,2*timescale,[])
	lep.wadd(self,"position",Vector2(0,500),calc.twoci,1.85*timescale,["parallel"])
	lep.start()
	await get_tree().create_timer(2).timeout
	for i in swaylerps:
		i.kill()

func dosway():
	swaylerps.append(calc.setLerp("add"))
	swaylerps[0].add(self,"position",Vector2(0,20),calc.hio,1*timescale,["loop head"])
	swaylerps[0].add(self,"position",Vector2(0,-20),calc.hio,1*timescale,["loop tail",-1])
	swaylerps.append(calc.setLerp("add"))
	swaylerps[1].add(self,"rotation_degrees",5,calc.hio,1.5*timescale,["loop head"])
	swaylerps[1].add(self,"rotation_degrees",-5,calc.hio,1.5*timescale,["loop tail",-1])

func generate():
	for i in pilesize:
		create()
		await get_tree().create_timer(0.05).timeout

func create():
	var a = CARD.instantiate()
	add_child(a)
	a.scale*=2.5
	a.spriteset(names.pick_random())
	a.rotation_degrees+= randf_range(-1,5)
	a.global_position.y-=get_child_count()*1
	pile.append(a)
	movecard(a)

func movecard(card):
	card.position += Vector2(-200,-400)
	var lep:additive_lerp = calc.setLerp("add")
	lep.add(card,"position",Vector2(200,400),calc.sqo,1*timescale,[])
	var lap:additive_lerp = calc.setLerp("add")
	lap.add(card,"position",Vector2(-100,100),calc.co,0.25*timescale,[])
	lap.add(card,"position",Vector2(200,-200),calc.hio,0.5*timescale,[])
	lap.add(card,"position",Vector2(-100,100),calc.ci,0.25*timescale,[])

func first():
	if not len(pile): return null
	return pile.pop_back()
