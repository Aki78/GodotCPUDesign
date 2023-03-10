extends Area2D

var show_coord = false
onready var mouse_pos # = get_viewport().get_mouse_position()
var mouse_down = false

func _ready():
	$ColorRect.hide()
	$ColorRect2.hide()

func _input(event):
	if event.is_action_pressed("delete") and Singleton.mode == "normal":
		Singleton.mode = "delete"
		$ColorRect.show()
		$ColorRect2.show()
	if event.is_action_pressed("grab") and Singleton.mode == "normal":
		Singleton.push_message("grabbing")
		Singleton.mode = "grab"

		for area in get_overlapping_areas():
			area.set_grab()

	if event.is_action_pressed("left_click") and Singleton.mode == "delete":
		for area in get_overlapping_areas():
			if area.is_in_group("switch"):
				area.queue_free()
			if area.is_in_group("wires"):
				get_tree().call_group(area.group_name, "queue_free")
			if area.is_in_group("gate"):
				print(area)
				area.queue_free()
	if event.is_action_pressed("escape"):
		$ColorRect.hide()
		$ColorRect2.hide()

	if event.is_action_pressed("show_coord"):
		if show_coord == false:
			show_coord = true

		else:
			$Coord.text = ""
			show_coord = false

	
func set_grab():
	pass
	

func _physics_process(delta):
	position = get_global_mouse_position()
#	print(get_overlapping_areas())
func _on_MouseTip_area_entered(area):
	if "current_wire_index" in area:
		print(area, " ", area.get_index(), " ", area.current_wire_index)

func _process(delta):
	if show_coord:
		$Coord.text = str(get_global_mouse_position())
	else:
		$Coord.text = ""


