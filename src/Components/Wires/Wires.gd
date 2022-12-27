extends Node2D
# Node to control the wires on the whole game,
# Only responsible for adding wires and frees empty wires.

var wire_path = "res://Components/Wires/Wire.tscn"
var Wire = load(wire_path)

func new_wire():
	var wire = Wire.instance()
	add_child(wire)
	wire.init()
#	Singleton.current_wire_index += 1

func _input(event):
	if event.is_action_pressed("escape"):
		Singleton.mode = "normal"
		free_empty_wires()

	if event.is_action_pressed("input"):
		free_empty_wires()
		Singleton.mode = "input"
		
	if event.is_action_pressed("wire") and Singleton.mode != "wire":
		free_empty_wires()
		Singleton.mode = "wire"
		new_wire()

func free_empty_wires():
	for _i in get_children():
		if _i.get_child_count() < 1:
			_i.queue_free()

func save():
	var wires_info = {"bundle_type": "Wires", "children" : [], "current_wire_index":Singleton.current_wire_index}
	for _i in get_children():
		wires_info.children.append(_i.save())
#	for _i in get_children():
#		print("wires:", _i.current_wire_index)
	return wires_info

func load_data(wires_info):
	if !wires_info:
		return
	print(wires_info)
	print(wires_info.current_wire_index)
	Singleton.current_wire_index = wires_info.current_wire_index
	for _i in wires_info.children:
		var wire = Wire.instance()
		add_child(wire)
		wire.init()
		wire.load_data(_i)

