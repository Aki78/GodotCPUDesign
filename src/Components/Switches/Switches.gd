extends Node2D
#Node for controlling Switches
#Only responsible for adding switches and 
#Moving switches on grab


onready var Switch = preload("res://Components/Switches/Switch.tscn")

var following = false

var current_switch

func _input(event):
	if event.is_action_pressed("add_switch") and Singleton.mode == "normal":
		Singleton.mode = "switch"
		create_switch()
		following = true
	if Singleton.mode == "switch" and event.is_action_pressed("left_click"):
				
		create_switch()
	if event.is_action_pressed("escape") and Singleton.mode == "switch":
		Singleton.mode = "normal"
		get_child(get_child_count() - 1).queue_free()
		following = false
	#if event.is_action_pressed("save") and Singleton.mode == "switch":
		#Singleton.mode = "normal"
		#get_child(get_child_count() - 1).queue_free()
		#following = false
		

func create_switch():
	
	var switch = Switch.instance()
	add_child(switch)
	var following = true
	current_switch = switch
	

func _process(delta):
	if following:
		current_switch.position = get_global_mouse_position()
		for _i in current_switch.get_overlapping_areas():
			if "bit" in _i and _i.is_in_group("wire"):
				current_switch.set_bit(_i.bit)

func save():
	for _i in get_children():
		Singleton.state.switches.append(_i.save())

func load_data(state):
	if !state:
		return
	for _i in state.switches:
		var switch = Switch.instance()
		add_child(switch)
		switch.load_data(_i)
#	get_child(get_child_count()-1).queue_free()
