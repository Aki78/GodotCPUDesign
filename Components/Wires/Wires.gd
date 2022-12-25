extends Node2D

var wire_index = 0
var Wire = load("res://Components/Wires/Wire.tscn")

func ready():
	pass
#	add_to_group("wires")

func new_wire():
	var wire = Wire.instance()
	add_child(wire)
	update_wire_index()

#	wire_index += 1

func _input(event):
	if event.is_action_pressed("escape"):
#		free_empty_wires()
		Singleton.mode = "normal"
		free_empty_wires()
		free_empty_wires()
		free_empty_wires()
		free_empty_wires()
		wire_index -= 1
	if event.is_action_pressed("input"):
		free_empty_wires()
		Singleton.mode = "input"
		
	if event.is_action_pressed("wire") and Singleton.mode != "wire":
		free_empty_wires()
		Singleton.mode = "wire"
		update_wire_index()
		new_wire()
		
func update_wire_index():
	for _i in get_children():
		_i.wire_index = wire_index

func free_empty_wires():
	for _i in get_children():
		if _i.get_child_count() < 1:
			_i.queue_free()
	wire_index = len(get_children())
	update_wire_index()
			
#func _process(delta):
#	update_wire_index()

