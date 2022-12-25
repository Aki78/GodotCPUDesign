extends Area2D

var bit = true
var old_bit = false
var grabbed = false


func _ready():
	add_to_group("contacts")
	scale *= 0.2
	
func _process(delta):
	for area in get_overlapping_areas():
		if area.is_in_group("wires"):
			if area.has_switch:
				bit = area.bit
			else:
				area.set_all_bit(bit)
#				area.set_all_bit(bit)
		Singleton.set_color(self)

func _input(event):
	if event.is_action_pressed("escape"):
		grabbed = false
	
func set_bit(new_bit):
	bit = new_bit

func toggle():
	if bit:
		bit = false
	else:
		bit = true
#func set_grab():
#	grabbed = true
	
#func _physics_process(delta):
#	if grabbed:
#		position = get_global_mouse_position()

func _physics_process(delta):
	if Singleton.mode == "grab" and grabbed:
		position = get_global_mouse_position() + Vector2(0, 10)
	else:
		grabbed = false


func set_grab():
	grabbed = true
	
