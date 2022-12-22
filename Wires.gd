extends Node2D


var wire_index = 0

var Wire = load("res://Wire.tscn")

func _input(event):
	if event.is_action_pressed("new_cord"):
		print("creating new cord")
		var wire = Wire.instance()
		add_child(wire)
		for _i in get_children():
			_i.wire_index = wire_index

		wire_index += 1
		

