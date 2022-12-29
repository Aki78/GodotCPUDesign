extends Node

var mode = "normal"
var file_name
var file_path
var _file

var state = {"wires" : [], "current_wire_index":0, "switches": [], "gates": []}
var command_stack = [0,0]

var count = 0


var current_wire_index = 0

var gate_type = "nand"

var global_message
func _ready():
	#Adding a pushable global message
	global_message = Label.new()
	global_message.text =  ""
	global_message.rect_position = -Vector2(0,250)
	var message_timer = Timer.new()
	message_timer.one_shot = true
	message_timer.wait_time = 1.0
	add_child(global_message)
	global_message.add_child(message_timer)
	

func push_message(message, dissapear = true, message_color="w"):
	global_message.text = message
	global_message.get_child(0).start()
	if dissapear:
		yield(global_message.get_child(0), "timeout")
		global_message.text = ""
	if message_color == "r":
		global_message.modulate.r = 1;
	else:
		global_message.modulate.r = 0;

func set_color(node):
#	if count %10 == 0:
#		print(node.bit, "node bit")
		if !node.bit:
			node.modulate.r = 4
			node.modulate.b = 0
			node.modulate.g = 0
		else:
			node.modulate.r = 0
			node.modulate.b = 4
			node.modulate.g = 0

func init():
	file_name = str(OS.get_cmdline_args())
#	file_name = "test.gdlg"
	if file_name:
		file_name = file_name.replace("[","")
		file_name = file_name.replace("]","")
	if !file_name:
#		push_error("NO FILE GIVEN")
		#printerr("Must provide a .gdlg file to store data.")
		file_path = "user://save_state.gdlg"
		file_name = "save_state.gdlg"
		#get_tree().quit()
	else:
		var extension_name = file_name.split(".")
		if extension_name[len(extension_name) - 1] != "gdlg":
			push_error("FILE EXTENSION NOT gdlg")
			printerr("Must provide a .gdlg file to store data. you provided " + file_name)
			get_tree().quit()
	var output = []
	var exit_code = OS.execute("realpath", [file_name], true, output)
	_file = File.new()
	#file_path = output[0].replace("\n","")
	#file_path = "/home/aki/Documents/buffer.gdlg"
	_file.open(file_path, _file.READ)
	var data = parse_json(_file.get_as_text())
	var main_node = get_tree().get_root().get_node("Game").get_node("Main")
	var wires_node = main_node.get_node("Wires")
	var switches_node = main_node.get_node("Switches")
	var gates_node = main_node.get_node("Gates")
	if data:
		wires_node.load_data(data)
		switches_node.load_data(data)
		gates_node.load_data(data)
	_file.close()

func save():
	var main_node = get_tree().get_root().get_node("Game").get_node("Main")
	var wires_node = main_node.get_node("Wires")
	var switches_node = main_node.get_node("Switches")
	var gates_node = main_node.get_node("Gates")
	wires_node.save()
	switches_node.save()
	gates_node.save()
	var my_text = JSON.print(state)
	_file.open(file_path, _file.WRITE)
	assert(_file.is_open())
	_file.store_string(my_text)
	_file.close()
	push_message("saved")
	

func _input(event):
	if event.is_action_pressed("save"):
		save()
	if mode != "normal":
		return
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER and event.scancode != KEY_SHIFT:
			print(event.scancode)
			command_stack[1]=command_stack[0]
			command_stack[0] = event.scancode
			print(KEY_COLON, " ", event.scancode, " " , KEY_Q)
			print(command_stack)
			if command_stack[1]== KEY_Z and command_stack[0]==KEY_Z:
				save()
				get_tree().quit()
			if command_stack[1]== KEY_SEMICOLON and command_stack[0]==KEY_Q:
#				save()
				print(KEY_COLON, " ", event.scancode)
				get_tree().quit()
			if command_stack[1]== KEY_SEMICOLON and command_stack[0]==KEY_W:
				save()
				print(KEY_COLON, " ", event.scancode)
				print("Saved")
				Singleton.mode = "normal"
	if event.is_action_pressed("center"):
		get_tree().get_root().get_node("Game").get_node("Camera2D").offset = Vector2(0,0)
		get_tree().get_root().get_node("Game").get_node("Camera2D").reset_zoom()
		Singleton.mode = "normal"
		command_stack = [0,0]

func copy_gate(new_type):
	gate_type = new_type

func _process(delta):
	count += 1
