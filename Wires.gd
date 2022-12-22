extends Node2D


var wire_index = 0
var Wire = load("res://Wire.tscn")

func _input(event):
	if Singleton.mode == "wire":
		if event.is_action_pressed("new_wire"):
			print("creating new wire ", wire_index)

#			if get_child_count() != 1:
			var wire = Wire.instance()
			add_child(wire)
#			if get_child(wire_index).get_child_count() != 0:
			for _i in get_children():
				_i.wire_index = wire_index
			wire_index += 1
				
	if event.is_action_pressed("escape"):
		Singleton.mode = "normal"
		free_empty_wires()
#		for _i in get_children():
#			_i.wire_index = wire_index - 1
		wire_index -= 1
	if event.is_action_pressed("input"):
		free_empty_wires()
		Singleton.mode = "input"
		
	if event.is_action_pressed("wire"):
		free_empty_wires()
		Singleton.mode = "wire"
		

func free_empty_wires():
	for _i in get_children():
		if _i.get_child_count() < 1:
			_i.queue_free()
	wire_index = len(get_children())
	print("new wire index:", wire_index)
			
