extends Area2D

var bit = false

func _physics_process(delta):
	for area in get_overlapping_areas():
		if name == "In1" or name == "In2":
			if  area.is_in_group("switch") or area.is_in_group("wires"):
				bit = area.bit

func _process(delta):
	Singleton.set_color(self)
		