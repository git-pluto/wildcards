extends actions

func conditions():
	if not body.duel.facing(body): # n precisa adicionar a condição de ja ter ficado 1 rodada pois essa ação nao é base
		return true
	return false

func do():
	pass # criar função de escolha a partir de uma aray de criaturas pra puxar o oponente escolhido pro duelo
