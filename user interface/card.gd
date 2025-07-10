extends Node2D

@onready var sprite: Sprite2D = $pivot/blank/sprite
@onready var backside: Sprite2D = $pivot/Backside
@onready var pivot: Node2D = $pivot

@onready var coll: CollisionShape2D = $pivot/Area2D/CollisionShape2D

var mouseon = false

func _on_area_2d_mouse_entered() -> void:
	mouseon = true
	get_node("../..").engage()

func _on_area_2d_mouse_exited() -> void:
	mouseon = false
	get_node("../..").check_fall()

func fliptoggle():
	backside.visible = not backside.visible

func collision(boo):
	coll.disabled = not boo

func spriteset(Xname):
	var tex = load("res://critter sprites/"+Xname+".png")
	sprite.texture = tex
