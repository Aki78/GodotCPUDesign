extends Camera2D

var mouse_down = false
var mouse_position_before

export var label_pos : Vector2 = Vector2(-450,250)
export var help_pos : Vector2 = Vector2(400,-250)

signal zoom_in
signal zoom_out

func ready():
	$ModeLabel.rect_position = label_pos
	$HelpLabel.rect_position = help_pos

func _input(e):
	if Input.is_action_pressed("zoomin") and zoom.x > 0.1:
		zoom *= 0.9
		$ModeLabel.rect_scale *= 0.9
		$HelpLabel.rect_scale *= 0.9
		emit_signal("zoom_in")
	if Input.is_action_pressed("zoomout") and zoom.x < 10:
		emit_signal("zoom_out")
		zoom *= 1.1
		$ModeLabel.rect_scale *= 1.1
		$HelpLabel.rect_scale *= 1.1
	if Input.is_action_pressed("middle_mouse"):
		mouse_down = true
	else:
		mouse_down = false

func _process(delta):
	var mouse_position_now = get_global_mouse_position()
	if mouse_down:
		offset += 50*delta*(-mouse_position_now + mouse_position_before)

	mouse_position_before = mouse_position_now
	$ModeLabel.rect_position = offset + zoom*label_pos
	$HelpLabel.rect_position = offset + zoom*help_pos
