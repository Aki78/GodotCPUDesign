extends Node2D

onready var Line = load("res://Components/Wires/Line.tscn")

var p1
var p2
var thickness : float = 2
var theta
var line_index = 0
var last_center
var current_wire_index = 0
var bit = false
var group_name
var old_bit = true
var has_absolute = false

var grabbed = false

var grab_point

func _ready():
	line_index = 0
#	group_name = "wire" + str(current_wire_index) # str(get_index())

	add_to_group("switchable")
	add_to_group("wires")
	
func init(new_index):
	group_name = "wire" + str(new_index) # str(current_wire_index) # str(get_index())
	add_to_group(group_name)
	
func set_bit(new_bit):
	bit = new_bit

func _input(event):
	if event.is_action_pressed("escape"):
		grabbed = false
	if Singleton.mode != "wire":
		return
	if is_in_group("wire" + str(current_wire_index)):
		if event.is_action_pressed("escape"):
			grabbed = false
			if get_child_count() > 0:

				get_child(line_index - 1).queue_free() #erase last line
		if event.is_action_pressed("left_click"):
				
			var line = Line.instance()
			add_child(line)
			if len(get_children()) > 1:
				last_center = get_child(line_index -1).center2
			else:
				last_center = get_global_mouse_position()
			line.init(last_center, group_name)
			line.thickness = thickness
			line.connect("grabbed", self, "on_grabbed")

			for _i in get_children():
				_i.current_index = line_index
			line_index = get_child_count() 

func add_switch():
	has_absolute = true
	
func delete_switch():
	has_absolute = false

func _physics_process(delta):
#	if old_bit == bit:
#		return
	for _i in get_children():
		_i.set_bit(bit)
	old_bit = bit
	
func on_grabbed():
	grabbed = true
	grab_point = get_global_mouse_position()


func _process(delta):
	if grabbed:
		position = get_global_mouse_position() - grab_point

