extends Node

@onready var hand: Hand = $hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand.doangles()

func _input(event: InputEvent) -> void:
	if event.is_action("ui_up"):
		hand.engage()
	if event.is_action("ui_down"):
		hand.disengage()
