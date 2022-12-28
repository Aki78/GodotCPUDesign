extends Area2D
#Node for gate outputs.

var bit = true

func _ready():
	add_to_group("out")
	add_to_group("absolute")
	modulate.a = 0.5

#func _process(delta):
#	print(get_overlapping_areas())
	
	Singleton.set_color(self)
		
