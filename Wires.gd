extends Node2D

var wire_index = 0
var Wire = load("res://Wire.tscn")

func new_wire():
	print("creating new wire ", wire_index)
	var wire = Wire.instance()
	add_child(wire)
	for _i in get_children():
		_i.wire_index = wire_index
#	wire_index += 1
	

func _input(event):

	if event.is_action_pressed("escape"):
		Singleton.mode = "normal"
		free_empty_wires()
		free_empty_wires()
	if event.is_action_pressed("input"):
		free_empty_wires()
		Singleton.mode = "input"
		
	if event.is_action_pressed("wire") and Singleton.mode != "wire":

		free_empty_wires()


	#		free_empty_wires()
		Singleton.mode = "wire"
		new_wire()
		
func free_empty_wires():
	for _i in get_children():
		if _i.get_child_count() < 1:
			_i.queue_free()
	wire_index = len(get_children())
	print("new wire index:", wire_index)
	print("number of wires:", get_child_count())
	print("number of wires:", len(get_children()))
			
