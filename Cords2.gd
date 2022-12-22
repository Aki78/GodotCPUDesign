extends Node2D

onready var Cord2 = load("res://Cord2.tscn")

var p1
var p2
var thickness = 5
var theta
var last_index = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			var cord2 = Cord2.instance()
			var center = get_global_mouse_position()
#			var theta = get_angle_to(get_global_mouse_position())
			cord2.self_index = last_index
			add_child(cord2)
			last_index += 1
				
