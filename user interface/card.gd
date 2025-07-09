extends Node2D

@onready var sprite: Sprite2D = $pivot/blank/sprite
@onready var backside: Sprite2D = $pivot/Backside


var mouseon = false

func _on_area_2d_mouse_entered() -> void:
	mouseon = true
	get_node("../..").engage()

func _on_area_2d_mouse_exited() -> void:
	mouseon = false
	get_node("../..").check_fall()

func fliptoggle():
	backside.visible = not backside.visible
