extends Area2D


var bit = false

func _ready():
	pass # Replace with function body.



func set_grab():
	pass

func _physics_process(delta):
	for area in get_overlapping_areas():
		if name == "Inp1" or name == "Inp2":
			if  area.is_in_group("switch") or area.is_in_group("wires"):
				bit = area.bit
		if name == "Out":
			if area.has_method("set_all_bit"):
				area.set_all_bit(bit)
#	print("gete: ", name , bit)
