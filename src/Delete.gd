extends Area2D

func _ready():
	$ColorRect.hide()
	$ColorRect2.hide()
	

func _input(event):
	
	if event.is_action_pressed("delete") and Singleton.mode == "normal":
		Singleton.mode = "delete"
		$ColorRect.show()
		$ColorRect2.show()
	if event.is_action_pressed("grab") and Singleton.mode == "normal":
		Singleton.mode = "grab"

		for area in get_overlapping_areas():
			area.set_grab()
		
	if event.is_action_pressed("left_click") and Singleton.mode == "delete":

		for area in get_overlapping_areas():
			if area.is_in_group("switch"):
				area.queue_free()
			if area.is_in_group("wires"):
				get_tree().call_group(area.group_name, "queue_free")
	if event.is_action_pressed("escape"):
		$ColorRect.hide()
		$ColorRect2.hide()
	
func set_grab():
	pass
	

func _physics_process(delta):
	position = get_global_mouse_position()
