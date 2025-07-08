extends Node2D
class_name Display_obj

var pos: Vector3 = Vector3(0,0,0)

var front = null
var left = null
var back = null
var right = null

@onready var sprite: Sprite2D = $pivot/Sprite2D

@onready var pivot: Node2D = $pivot
