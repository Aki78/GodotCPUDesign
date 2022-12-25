extends Node2D

onready var Gate = preload("res://Components/Gates/Gate.tscn")

var following = false
var current_gate


func _input(event):
	if event.is_action_pressed("add_gate") and Singleton.mode == "normal":
		Singleton.mode = "gate"
		create_gate()
		following = true
	if Singleton.mode == "gate" and event.is_action_pressed("left_click"):
		for inout in current_gate.get_node("Areas").get_children():
			for area in inout.get_overlapping_areas():
				if area.is_in_group("switch"):
					return
				if area.is_in_group("wires"):
						return
		create_gate()

	if event.is_action_pressed("escape") and Singleton.mode == "gate":
		Singleton.mode = "normal"
		get_child(get_child_count() - 1).queue_free()
		following = false

func create_gate():
	
	var gate = Gate.instance()
	add_child(gate)
	var following = true
	current_gate = gate
	

func _process(delta):
	if following:
		current_gate.position = get_global_mouse_position()
		#for _i in current_gate.get_overlapping_areas():
			#if "bit" in _i and _i.is_in_group("wire"):
				#current_gate.set_bit(_i.bit)
		
