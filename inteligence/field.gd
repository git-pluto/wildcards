extends Node

var active = []

var preparing = []
var backline = []
var frontline = []

var matrix = [preparing, backline, frontline]

#func navigate(brain, move: Vector2):
	#var row = 0
	#while not matrix[row].has(brain):
		#row+=1
		#if row == 3: break
	#var place = matrix[row].find(brain)
	#
