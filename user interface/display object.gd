extends Node2D
class_name Display_obj

var pos: Vector3 = Vector3(0,0,0)

var front = null
var left = null
var back = null
var right = null

@onready var sprite: Sprite2D = $pivot/sprite
@onready var shadow: Sprite2D = $pivot/shadow
@onready var haze: ColorRect = $pivot/sprite/haze


@onready var pivot: Node2D = $pivot

var critter_brain

func spriteset(Xname):
	var tex = load("res://critter sprites/"+Xname+".png")
	sprite.texture = tex
	shadow.texture = tex
	shadow.position += values.get_shadow_offset(Xname)
