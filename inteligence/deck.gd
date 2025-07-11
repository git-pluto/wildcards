extends Node

@onready var team: teamclass = $".."
const CRITTER_BODY = preload("res://critters/critter_body.tscn")

var pile = []

func first():
	if not len(pile): return null
	return pile.back()

func take_first():
	if not len(pile): return null
	return pile.pop_back()

func generate(arr):
	for i in arr:
		var a = CRITTER_BODY.instantiate()
		add_child(a)
		a.set_script(load("res://critters/"+i+".gd"))
		pile.append(a)
	team.admin.set_deck()
