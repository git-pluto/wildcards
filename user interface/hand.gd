extends Node2D
class_name Hand

var height_tween: Tween
var spread_tween: Tween
var space_tween: Tween
var pop_tweens = []

var pos = Vector3(10,200,100)
var haze = null

@onready var pivot: Node2D = $pivot
@onready var pointer: Node2D = $pointer

var angles: Array = []
var risen: bool = false
var hovered

func grab(card: Node2D):
	if card == null: return
	pointer.look_at(card.global_position)
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_parallel()
	tween.tween_property(card,"rotation_degrees", pointer.rotation_degrees+90,0.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(card,"global_position", pivot.global_position,0.7).set_ease(Tween.EASE_IN)
	var twen = create_tween().set_trans(Tween.TRANS_EXPO)
	twen.tween_property(card.pivot,"scale:x", 0,0.25).set_ease(Tween.EASE_IN)
	twen.tween_callback(func():card.fliptoggle())
	twen.tween_property(card.pivot,"scale:x", 1,0.25).set_ease(Tween.EASE_OUT)
	await tween.finished
	card.pivot.position = Vector2(0,-200)
	card.collision(true)
	card.reparent(pivot, true)
	card.scale = Vector2(1,1)
	doangles()
	if not check_fall(): engage()

func check_fall():
	if not children().any(func(i): return i.mouseon):
		disengage()
		return true
	return false

func _process(_delta: float) -> void:
	if risen:
		pointer.look_at(get_global_mouse_position())
		hover(check_angles(pointer.rotation_degrees+90))

func engage(): # rise up and spread out
	pivot_spread(spacing())
	pivot_height(170)
	risen = true
func disengage(): # sink down and close up
	pivot_spread(1)
	pivot_height(200)
	pop_down_up(hovered,null)
	spread_space(child_count())
	hovered = null
	risen = false


func hover(x: int):
	if hovered == null:
		hovered = x
		spread_space(x)
		pop_down_up(null,hovered)
	elif hovered != x:
		# just need to do the pop down of the old hovered and the pop up of the new x
		pop_down_up(hovered,x)
		spread_space(x)
		hovered = x


func spacing(): # controls the separation between each card in hand when it is engaged (disengaged is allways 1)
	return 10/(child_count()**0.6)
func child_count():
	return pivot.get_child_count()
func children():
	return pivot.get_children()


func doangles(): # retorna por exemplo [-2, -1, 0, 1, 2] quando impar e [-1.5, -0.5, 0.5, 1.5] quando par
	angles = []
	for i in child_count():
		angles.append(i+0.5-float(child_count())/2)
func check_angles(x):
	for i in angles:
		if x<(i*spacing())+spacing()/2: # dá o offset para que cada range de ângulos seja centralizado
			return angles.find(i)
	return len(angles)-1 # retorna o index do filho que deve ser selecionado


func pivot_height(x: float):
	if height_tween:
		height_tween.kill()
	height_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	height_tween.tween_property(pivot, "position:y", x, 0.25)
func pivot_spread(x: float):
	if spread_tween:
		spread_tween.kill()
	if child_count():
		spread_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).set_parallel()
		for i in children():
			spread_tween.tween_property(i, "rotation_degrees", angles[children().find(i)]*x, 0.2)
func spread_space(x: int): # para zerar o espaço, é só colocar spread_space(child_count())
	if space_tween:
		space_tween.kill()
	if child_count():
		space_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).set_parallel()
		for i in child_count():
			if i <= x:
				space_tween.tween_property(children()[i], "position:x", 0, 0.1)
			else:
				space_tween.tween_property(children()[i], "position:x", 50, 0.1)
func pop_down_up(d,u):
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_EXPO)
	pop_tweens.append(tween)
	if d != null:
		tween.tween_property(children()[d],"scale",Vector2(1,1),0.2).set_ease(Tween.EASE_IN)
	if u != null:
		tween.tween_property(children()[u],"scale",Vector2(1.1,1.1),0.2).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func():pop_tweens.erase(tween))
