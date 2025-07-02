extends Node
class_name critter_body

@onready var team: teamclass = $"../.."

var duel: duel_class

var stats: Dictionary = {
	"hp": 0,
	"atk": 0,
	"size": 0,
	"def": 0
}

func set_triggers():
	team.add_trigger("strike",self)

func trigger(text: String, data: Array):
	match text:
		"strike":
			var aux = data[0]+data[1]-stats["size"]-stats["def"]
			if aux>0:
				trigger("hurt",[aux])
		"hurt":
			stats["hp"] -= data[0]
			team.team_emit([self],"ally hurt",[self])
