extends Node2D

var line_path = "res://Components/Wires/Line.tscn"
onready var Line = load("res://Components/Wires/Line.tscn")

var p1
var p2
var thickness : float = 2
var theta
var line_index = 0
var last_center
var current_wire_index = 0
var current_line_index = 0
var bit = false
var group_name
var old_bit = true
var has_absolute = false

var grabbed = false

var grab_point

func _ready():
	current_line_index = 0
	add_to_group("switchable")
	add_to_group("wires")
	
func init(new_index):
	group_name = "wire" + str(new_index)
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

				get_child(current_line_index -1).queue_free() #erase last line when escape
		if event.is_action_pressed("left_click"):
			print("left click")
				
			var line = Line.instance()
			add_child(line)
			if len(get_children()) > 1:
				print(get_children(), current_wire_index, " ", current_line_index)
				#Magic?
				print(line_index, get_child_count())
#				current_line_index = get_child_count() 
				last_center = get_child(current_line_index -1).center2
			else:
				last_center = get_global_mouse_position()
			line.init(last_center, group_name)
			line.thickness = thickness
			line.connect("grabbed", self, "on_grabbed")
			#Update wires index to all lines
			for _i in get_children():
				_i.current_wire_index = current_wire_index
			current_line_index = get_child_count()
			print(current_wire_index)
#			line_index += 1

func add_switch():
	has_absolute = true
	
func delete_switch():
	has_absolute = false

func _physics_process(delta):
	if old_bit == bit:
		return
	for _i in get_children():
		_i.set_bit(bit)
	old_bit = bit
	
func on_grabbed():
	grabbed = true
	grab_point = get_global_mouse_position()


func _process(delta):
	if grabbed:
		position = get_global_mouse_position() - grab_point
		
func save(parent_path):
	var wire_info = {"append_to":"Wires","node": parent_path, "children":[], "group_name":group_name}
	for _i in get_children():
		wire_info.children.append(
			{
				"node": line_path,
				"bit": _i.bit,
				"polyC_poly":var2str(_i.polyC.polygon),
				"polyR_poly":var2str(_i.polyR.polygon),
				"group_name":_i.group_name,
				"center2": var2str(_i.center2),
				"center1": var2str(_i.center1)
			}
		)
	return wire_info
	
func load_data(children, new_wire_index):
	pass
#	current_wire_index =  new_wire_index
#	group_name = children.group_name
#	var ind = 0
#	for _i in children.children:
#		var line = Line.instance()
#		line.bit = _i.bit
#		add_child(line)
#		line.polyC.set_polygon(str2var(_i.polyC_poly))
#		line.polyR.set_polygon(str2var(_i.polyC_poly))
#		line.group_name = _i.group_name
#		line.current_wire_index = ind
#		line.has_absolute = false
#		line.add_to_group(group_name)
#		line.center2 = str2var(_i.center2)
#		line.center1 = str2var(_i.center1)
#		ind += 1
#		print(get_child_count())
#	get_child(get_child_count() -1).queue_free()
#	last_center = get_child(get_child_count() -1).center2
#
	

