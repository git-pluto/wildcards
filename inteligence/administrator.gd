extends Node

@onready var draw_pile: Node2D = $"draw pile"

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
	await get_tree().create_timer(0.2).timeout
	#$hand.doangles()
	#$hand.disengage()
	#for i in $hand/pivot.get_children():
		#i.sprite.texture = load("res://critter sprites/"+names.pick_random()+".png")
	$logic/team.generate_deck(["shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp",])
	$"draw pile".set_and_draw()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("d"):
		draw()

func draw():
	$hand.grab($"draw pile".first())

func set_deck():
	draw_pile.generate($logic/team/deck.get_children())
