extends Node
class_name teamclass

@onready var deck: Node = $deck
@onready var hand: Node = $hand
@onready var field: Node = $field
@onready var discard: Node = $discard
@onready var duels: Node = $"../duels"
const DUEL = preload("res://inteligence/duel.tscn")

var triggers = {}
var points = 0

func draw(): # move a card from the deck to the hand
	if deck.get_child_count() > 0:
		deck.get_child(0).reparent(hand)

func play(ind: int): # move a card from the hand to the field
	hand.get_child(ind).reparent(field)

func exaust(card: critter_body): # move any card to the discard pile
	card.reparent(discard)

func team_emit(exclude: Array, key: String, data: Array):
	if not triggers.keys().has(key): # isso significa que ninguem recebe o trigger
		return
	for i:critter_body in triggers[key]:
		if not exclude.has(i):i.trigger(key,data)

func add_trigger(key: String, body: Node):
	if triggers.keys().has(key):
		triggers[key].append(body)
	else:
		triggers[key] = [body]

func remove_trigger(body): # basicamente pra morte. remove todos os triggers relacionados ao corpo
	for i:Array in triggers.values():
		if i.has(body): i.erase(body)

func point(_body): # WIP
	points+=1

func challenge(body: critter_body):
	var d:duel_class = DUEL.instantiate()
	duels.add_child(d)
	d.include(body)
