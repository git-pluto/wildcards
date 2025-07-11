extends Node

@onready var draw_pile: Node2D = $"draw pile"
@onready var hand: Hand = $hand

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

	$logic/team.deck.generate(["shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp","shrimp",])
	$"draw pile".set_and_draw()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("d"):
		draw()

func draw():
	$logic/team.hand.draw($logic/team.deck.take_first())

func set_deck():
	draw_pile.generate($logic/team/deck.get_children())
