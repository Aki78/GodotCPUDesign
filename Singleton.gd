extends Node


var mode = "normal"


func set_color(node):
	if !node.bit:
		node.modulate.r = 255
		node.modulate.b = 0
	else:
		node.modulate.r = 0
		node.modulate.b = 255
