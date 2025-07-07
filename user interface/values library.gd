extends Node

const sprite_offset = {
	"Lyrebird": Vector2(0,-40),
	"bullfrog": Vector2(0,-10)
}

const pivot_offset = {
	"pearl oyster": Vector2(0,20),
	"Lyrebird": Vector2(0,30),
	"bullfrog": Vector2(0,10),
	"firefly": Vector2(0,-50)
}

func get_sprite_offset(key):
	if sprite_offset.has(key):
		return sprite_offset[key]
	else:
		return Vector2(0,0)

func get_pivot_offset(key):
	if pivot_offset.has(key):
		return pivot_offset[key]
	else:
		return Vector2(0,0)
