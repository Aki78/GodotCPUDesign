extends Node2D

onready var Cord2 = load("res://Cord2.tscn")

var p1
var p2
var thickness : float = 0.5
var theta
var cord_index = 0
var last_center
var cable_index = 0

func _ready():
	cord_index = 0

func _input(event):

	if get_index() == cable_index:
		print("innter cable", cord_index)
		if event.is_action_pressed("new_cord"):
			get_child(cord_index - 1).queue_free()
		if event.is_action_pressed("left_click"):
				
			var cord2 = Cord2.instance()
			add_child(cord2)
			if len(get_children()) > 1:
				print(len(get_children()))
				print("hit")
				print(get_children(), cord_index)
				last_center = get_child(cord_index -1).center2
			else:
				print("hit2")
				last_center = get_global_mouse_position()
			print(last_center)
			cord2.init(last_center)
			cord2.thickness = thickness
			print(last_center)

			for _i in get_children():
				_i.current_index = cord_index
			cord_index += 1

				


