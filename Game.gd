extends Node2D

func _ready():
	$Help.hide()


func _input(event):
	if event.is_action_pressed("help"):
		$Main.hide()
		$Help.show()
		Singleton.mode = "help"
	if event.is_action_pressed("escape"):
		$Help.hide()
		$Main.show()
