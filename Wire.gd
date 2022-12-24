extends Node2D

onready var Line = load("res://Line.tscn")

var p1
var p2
var thickness : float = 0.5
var theta
var line_index = 0
var last_center
var wire_index = 0
var bit = false
var group_name
var old_bit = true
var has_switch = false

func _ready():
	line_index = 0
	group_name = "wire" + str(get_index())
	add_to_group(group_name)
	add_to_group("switchable")
	add_to_group("wires")
	
func set_bit(new_bit):
#	print("setting bit")
	bit = new_bit

func _input(event):
	if Singleton.mode != "wire":
		return
	if get_index() == wire_index:
		print("index", get_index())
		print("current_wire_index", wire_index)
		if event.is_action_pressed("escape"):
			if get_child_count() > 0:
				print("child couhnt:", get_child_count())
				print("child couhnt:", line_index)
				get_child(line_index - 1).queue_free() #erase last line
#			else:
#				queue_free()
#				wire_index -= 1
		if event.is_action_pressed("left_click"):
				
			var line = Line.instance()
			add_child(line)
			if len(get_children()) > 1:
				last_center = get_child(line_index -1).center2
			else:
				print("hit2")
				last_center = get_global_mouse_position()
			print(last_center)
			line.init(last_center, group_name)
			line.thickness = thickness
			print(last_center)

			for _i in get_children():
				_i.current_index = line_index
			line_index = get_child_count() 
#			line_index += 1

func add_switch():
	has_switch = true
	
func delete_switch():
	has_switch = false

func _physics_process(delta):
#	if old_bit == bit:
#		return
	for _i in get_children():
		_i.set_bit(bit)
	old_bit = bit

