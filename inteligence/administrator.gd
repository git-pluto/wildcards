extends Node

var names = ["bullfrog",
"cheerleader crab",
"decorator crab",
"firefly",
"giant snail",
"Lyrebird",
"nautilus",
"pearl oyster",
"silverfish"]

func _ready() -> void:
	await ready
	$hand.doangles()
	$hand.disengage()
	for i in $hand/pivot.get_children():
		i.sprite.texture = load("res://critter sprites/"+names.pick_random()+".png")
