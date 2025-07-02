extends Node
class_name duel_class

var bodies = []

func facing(body):
	if bodies.size() < 2: return false
	return bodies[bodies.find(not body)]

func include(body: critter_body):
	if bodies.size() >= 2:
		print("duelo cheio!")
		return
	bodies.append(body)
	body.duel = self
