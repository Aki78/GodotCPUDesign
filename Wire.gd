extends Node2D

onready var Line = load("res://Line.tscn")

var p1
var p2
var thickness : float = 0.5
var theta
var cord_index = 0
var last_center
var wire_index = 0
var bit = false
var group_name

func _ready():
	cord_index = 0
	group_name = "wire" + str(get_index())
	add_to_group(group_name)
	
func set_bit(new_bit):
	bit = new_bit

func _input(event):
	if get_index() == wire_index:
		if event.is_action_pressed("new_cord"):
			get_child(cord_index - 1).queue_free()
		if event.is_action_pressed("left_click"):
				
			var line = Line.instance()
			add_child(line)
			if len(get_children()) > 1:
				last_center = get_child(cord_index -1).center2
			else:
				print("hit2")
				last_center = get_global_mouse_position()
			print(last_center)
			line.init(last_center, group_name)
			line.thickness = thickness
			print(last_center)

			for _i in get_children():
				_i.current_index = cord_index
			cord_index += 1

				
func _physics_process(delta):
	for _i in get_children():
		_i.set_bit(bit)

