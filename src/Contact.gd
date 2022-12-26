extends Area2D

var bit = true

func _physics_process(delta):
	for area in get_overlapping_areas():
		if name[0] == "I" and name[1] == "n":
			if  area.is_in_group("switch") or area.is_in_group("wires"):
				bit = area.bit

func _process(delta):
	Singleton.set_color(self)
		
