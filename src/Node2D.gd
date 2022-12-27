extends Control

func _ready():
	connect("mouse_button", self, "_on_mouse_button")

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			pass
		else:
			pass
	if event is InputEventMouseMotion:
