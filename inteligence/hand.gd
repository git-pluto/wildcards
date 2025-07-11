extends Node

@onready var team: teamclass = $".."

func draw(brain):
	team.admin.hand.grab(brain.interface_element)
	brain.reparent(self)
