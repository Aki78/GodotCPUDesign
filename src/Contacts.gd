extends Node2D

onready var Contact = preload("res://Components/Contacts/Contact.tscn")

var following = false
var current_contact

func _input(event):
	if event.is_action_pressed("add_contact") and Singleton.mode == "normal":
		Singleton.mode = "contact"
		create_contact()
		following = true
	if Singleton.mode == "contact" and event.is_action_pressed("left_click"):
		for inout in get_children():
			for area in inout.get_overlapping_areas():
				if area.is_in_group("switch"):
					return
				if area.is_in_group("wires"):
					pass
		create_contact()

	if event.is_action_pressed("escape") and Singleton.mode == "contact":
		Singleton.mode = "normal"
		get_child(get_child_count() - 1).queue_free()
		following = false

func create_contact():
	
	var contact = Contact.instance()
	add_child(contact)
	var following = true
	current_contact = contact
	

func _process(delta):
	if following:
		current_contact.position = get_global_mouse_position()
		#for _i in current_contact.get_overlapping_areas():
			#if "bit" in _i and _i.is_in_group("wire"):
				#current_contact.set_bit(_i.bit)
		
