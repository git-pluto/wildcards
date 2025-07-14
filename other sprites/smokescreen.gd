extends Node2D

const SMOKE_1 = preload("res://other sprites/smoke1.png")
const SMOKE_2 = preload("res://other sprites/smoke2.png")
const SMOKE_3 = preload("res://other sprites/smoke3.png")
const SMOKE_4 = preload("res://other sprites/smoke4.png")
var smokes = [SMOKE_1,SMOKE_1,SMOKE_2,SMOKE_2,SMOKE_3,SMOKE_3,SMOKE_4]

func _ready() -> void:
	for i in 500:
		await get_tree().create_timer(0.5).timeout
		make_poof()

func make_poof():
	var a := Sprite2D.new()
	add_child(a)
	a.texture = smokes.pick_random()
	a.modulate.a = 0
	a.position.x = randi_range(-60,60)
	a.position.y = randi_range(-30,30)
	a.scale*=randf_range(0.8,1.2)
	var magnitude = randf_range(0.5,1.5)
	
	a.position.x/=magnitude
	a.scale*=magnitude
	a.scale*=Vector2([1,-1].pick_random(),[1,-1].pick_random())
	
	var tween = create_tween()
	tween.tween_property(a,"modulate:a", 1,2*magnitude).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(a,"position:x", 0,2*magnitude)
	tween.tween_property(a,"modulate:a", 0,2*magnitude).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(a,"position:x", -a.position.x,2*magnitude)
	tween.tween_callback(func():a.queue_free())
