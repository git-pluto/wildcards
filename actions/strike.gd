extends actions

func conditions():
	return !(body.facing == null)

func do():
	body.facing.trigger("strike", [body.stats["atk"],body.stats["size"]])
