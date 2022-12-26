extends Area2D
#Node for gate outputs.

var bit = false

func _ready():
	if name[0]=="O" and name[1] =="u":
		add_to_group("out")
		add_to_group("absolute")
		modulate.a = 0.5

func _process(delta):
	print("out: ", bit)
	print(get_overlapping_areas())
	Singleton.set_color(self)
		
