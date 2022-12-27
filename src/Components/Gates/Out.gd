extends Area2D
#Node for gate outputs.

var bit = true

func _ready():
	if name[0]=="O" and name[1] =="u":
		add_to_group("out")
		add_to_group("absolute")
		modulate.a = 0.5

func _process(delta):
	
	
	Singleton.set_color(self)
		
