extends Area2D

var bit = false

func _physics_process(delta):
	for area in get_overlapping_areas():
		if area.has_method("set_all_bit") and area.is_in_group("wires"):
			area.set_all_bit(bit)

func _process(delta):
	Singleton.set_color(self)
		
