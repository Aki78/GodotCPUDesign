extends Area2D


func _input(event):
	
	if event.is_action_pressed("delete") and Singleton.mode == "normal":
		Singleton.mode = "delete"
		
	if event.is_action_pressed("left_click") and Singleton.mode == "delete":

		for area in get_overlapping_areas():
			if area.is_in_group("switch"):
				print("deleting", area)
				area.queue_free()
			if area.is_in_group("wires"):
				get_tree().call_group(area.group_name, "queue_free")
	
	

	

func _process(delta):
	position = get_global_mouse_position()
