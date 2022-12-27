extends Node

var mode = "normal"
var file_name
var file_path
var _file

var current_wire_index = 0

func set_color(node):
	if !node.bit:
		node.modulate.r = 255
		node.modulate.b = 0
	else:
		node.modulate.r = 0
		node.modulate.b = 255

func init():
	file_name = str(OS.get_cmdline_args())
#	file_name = "test.gdlg"
	if file_name:
		file_name = file_name.replace("[","")
		file_name = file_name.replace("]","")
	print(file_name)
	file_name = "buffer.gdlg"
	if !file_name:
#		push_error("NO FILE GIVEN")
		printerr("Must provide a .gdlg file to store data.")
		file_name = "buffer.gdlg"
		file_path = "/home/aki/Documents/buffer.gdlg"
		get_tree().quit()
	else:
		print(file_name)
		var extension_name = file_name.split(".")
		if extension_name[len(extension_name) - 1] != "gdlg":
			push_error("FILE EXTENSION NOT gdlg")
			printerr("Must provide a .gdlg file to store data.")
			get_tree().quit()
	var output = []
	var exit_code = OS.execute("realpath", [file_name], true, output)
	_file = File.new()
#	file_path = output[0].replace("\n","")
	file_path = "/home/aki/Documents/buffer.gdlg"
	_file.open(file_path, _file.READ)
	var data = parse_json(_file.get_as_text())
	print("Saving")
	var main_node = get_tree().get_root().get_node("Game").get_node("Main")
	var wires_node = main_node.get_node("Wires")
	wires_node.load_data(data)
	_file.close()

func save():
	print("Saving")
	var main_node = get_tree().get_root().get_node("Game").get_node("Main")
	var wires_node = main_node.get_node("Wires")
	var my_text = JSON.print(wires_node.save())
	_file.open(file_path, _file.WRITE)
	assert(_file.is_open())
	_file.store_string(my_text)
	_file.close()
	

func _input(event):
	if event.is_action_pressed("save"):
		save()

