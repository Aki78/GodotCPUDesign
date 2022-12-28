extends Node2D

var line_path = "res://Components/Wires/Line.tscn"
onready var Line = load("res://Components/Wires/Line.tscn")

var p1
var p2
var thickness : float = 2
var theta
var line_index = 0
var last_center
var wire_index = 0
var current_line_index = 0
var group_name
var overlapping_absolute_nodes = []

var grabbed = false

var grab_point

func _ready():
	current_line_index = 0
	add_to_group("switchable")
	add_to_group("wires")
	
func init():
	wire_index =Singleton.current_wire_index
	group_name = "wire" + str(Singleton.current_wire_index)
	add_to_group(group_name)

func _input(event):
	if event.is_action_pressed("escape"):
		grabbed = false
	if Singleton.mode != "wire":
		return
	if wire_index == Singleton.current_wire_index:
		if event.is_action_pressed("escape"):
			grabbed = false
			if get_child_count() > 0:
				Singleton.current_wire_index += 1
				get_child(current_line_index).queue_free() #erase last line when escape

		if event.is_action_pressed("left_click"):
				
			var line = Line.instance()
			add_child(line)
			if len(get_children()) > 1:
				current_line_index = get_child_count() -1
				last_center = get_child(current_line_index - 1).center2
			else:
				last_center = get_global_mouse_position()
			line.init(last_center, group_name)
			line.thickness = thickness
			line.connect("grabbed", self, "on_grabbed")
			line.connect("send_bit", self, "on_send_bit")
			#Update wires index to all lines
			for _i in get_children():
#				_i.group_name = group_name
				_i.current_line_index = current_line_index
			current_line_index = get_child_count() - 1

func _physics_process(delta):
	if get_child_count() > 0 and wire_index == Singleton.current_wire_index:
		get_child(current_line_index).update_last_line()
	
func on_grabbed():
	grabbed = true
	grab_point = get_global_mouse_position()

func _process(delta):
	if Singleton.count % 10 == 0:
		overlapping_absolute_nodes = []
		for _i in get_children():
			if _i.has_absolute:
				for _j in _i.overlapping_absolute_nodes:
					overlapping_absolute_nodes.append(_j)
		if len(overlapping_absolute_nodes) > 1:
			Singleton.push_message("More than one absolute!",true,"r")
	if grabbed:
		position = get_global_mouse_position() - grab_point

func on_send_bit(new_bit):
	for _i in get_children():
		_i.set_bit(new_bit)

func save():
	var wire_info = {"append_to":"Wires", "children":[], "wire_index": wire_index ,"group_name":group_name}
	for _i in get_children():
		wire_info.children.append(
			{
				"polyC_poly":var2str(_i.polyC.polygon),
				"polyR_poly":var2str(_i.polyR.polygon),
				"group_name":_i.group_name,
				"center2": var2str(_i.center2),
				"center1": var2str(_i.center1),
				"wire_index": wire_index - 1,
				"bit": _i.bit
			}
		)
	return wire_info
	
func load_data(children):
#	pass
	wire_index = children.wire_index 
	group_name = children.group_name
	var ind = 0
	for _i in children.children:
		var line = Line.instance()
		add_child(line)
		line.polyC.set_polygon(str2var(_i.polyC_poly))
		line.polyR.set_polygon(str2var(_i.polyC_poly))
		line.group_name = _i.group_name
		line.current_line_index = ind
		line.has_absolute = false
		line.add_to_group(group_name)
		line.center2 = str2var(_i.center2)
		line.center1 = str2var(_i.center1)
		line.bit = _i.bit
		ind += 1
		line.connect("send_bit",self,"on_send_bit")
		line.connect("grabbed", self, "on_grabbed")
		Singleton.set_color(line)
#	get_child(get_child_count() -1).queue_free()

	if get_child(get_child_count() -1):
		last_center = get_child(get_child_count() -1).center2
