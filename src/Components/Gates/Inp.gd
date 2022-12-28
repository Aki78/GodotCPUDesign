extends Area2D
#Node for gate inputs.

var bit = false

func _ready():
	add_to_group("inputs")

func _process(delta):
	Singleton.set_color(self)
#	print(get_overlapping_areas(), bit )
		

func set_bit(new_bit):
	bit = new_bit
