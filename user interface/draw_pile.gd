extends Node2D

const CARD = preload("res://user interface/card.tscn")
var timescale = 0.75

func _ready() -> void:
	await ready
	await get_tree().create_timer(0.2).timeout
	generate()

func generate():
	for i in 20:
		create()
		await get_tree().create_timer(0.05).timeout

func create():
	var a = CARD.instantiate()
	add_child(a)
	a.scale*=2.5
	a.rotation_degrees+= randf_range(-1,5)
	a.global_position.y-=get_child_count()*1
	movecard(a)

func movecard(card):
	card.position += Vector2(-200,-400)
	var lep:additive_lerp = calc.setLerp("add")
	lep.add(card,"position",Vector2(200,400),calc.li,1*timescale,[])
	var lap:additive_lerp = calc.setLerp("add")
	lap.add(card,"position",Vector2(-100,100),calc.co,0.25*timescale,[])
	lap.add(card,"position",Vector2(200,-200),calc.hio,0.5*timescale,[])
	lap.add(card,"position",Vector2(-100,100),calc.ci,0.25*timescale,[])
