extends Control

func _ready():
	# Connect the mouse_button signal to the _on_mouse_button function
	connect("mouse_button", self, "_on_mouse_button")

func _input(event):
	# Check if the left mouse button was pressed or released
	if event is InputEventMouseButton:
		if event.is_pressed():
			# Print "Hello" when the left mouse button is pressed
			print("Hello")
		else:
			# Print "World" when the left mouse button is released
			print("World")
	if event is InputEventMouseMotion:
		print(event.speed)
