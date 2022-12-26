extends Area2D

var bit = false

func _ready():
	if name[0]=="O" and name[1] =="u":
		add_to_group("out")
		add_to_group("absolute")
		modulate.a = 0.5

#func _physics_process(delta):
#	for area in get_overlapping_areas():
#		if area.has_method("set_all_bit") and area.is_in_group("wires"):
#			area.set_all_bit(bit)


func _process(delta):
	print("out: ", bit)
	print(get_overlapping_areas())
	Singleton.set_color(self)
		
