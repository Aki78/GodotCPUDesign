extends Node2D
#Every node, except for labels and controllers must be an area2D

func _ready():
	$Help.hide()
	Singleton.init()

func _input(event):
	if event.is_action_pressed("help") and Singleton.mode == "normal":
		$Main.hide()
		$Help.show()
		Singleton.mode = "help"
	if event.is_action_pressed("escape"):
		$Help.hide()
		$Main.show()
