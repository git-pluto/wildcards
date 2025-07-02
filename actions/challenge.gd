extends actions

func conditions():
	return (body.duel == null)

func do():
	body.team.challenge(body)
