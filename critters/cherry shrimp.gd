extends critter_body

func set_triggers():
	super()
	team.add_trigger("ally spawned",self)

func _ready() -> void:
	stats["hp"] = 3
	stats["atk"] = 0
	stats["size"] = 2
	stats["def"] = 1

func trigger(text: String, data: Array):
	super(text,data)
	match text:
		"ally spawned":
			team.point(self)
