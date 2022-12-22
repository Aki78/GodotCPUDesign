extends Node2D


var cable_index = 0

var Cable = load("res://Cable.tscn")


func _input(event):
	if event.is_action_pressed("new_cord"):
		print("creating new cord")
		var cable = Cable.instance()
		add_child(cable)
		for _i in get_children():
			_i.cable_index = cable_index

		cable_index += 1
		

