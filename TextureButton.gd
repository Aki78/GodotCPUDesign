extends TextureButton

var dragging

func _ready():
	# Connect the mouse_entered and mouse_exited signals to the _on_mouse_entered and _on_mouse_exited functions
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("mouse_motion", self, "_on_mouse_motion")

func _on_mouse_entered():
	# Enable dragging when the mouse enters the Control node
	dragging = true

func _on_mouse_exited():
	# Disable dragging when the mouse exits the Control node
	dragging = false


func _on_mouse_motion(event):
	# Update the position of the Control node based on the mouse position
	print("Hello")
	if dragging:
		rect_position = event.position
