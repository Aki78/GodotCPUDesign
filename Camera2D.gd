extends Camera2D

var mouse_down = false
var mouse_position_before

func _input(e):
	if Input.is_action_pressed("zoomin") and zoom.x > 0.5:
		zoom *= 0.9
	if Input.is_action_pressed("zoomout") and zoom.x < 2:
		zoom *= 1.1
	if Input.is_action_pressed("middle_mouse"):
		mouse_down = true
	else:
		mouse_down = false

func _process(delta):
	var mouse_position_now = get_global_mouse_position()
	if mouse_down:
		offset += 50*delta*(-mouse_position_now + mouse_position_before)
	mouse_position_before = mouse_position_now
