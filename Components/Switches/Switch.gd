extends Area2D

var bit = true
var old_bit = false
var grabbed = false

func _ready():
	add_to_group("switch")
	add_to_group("switchable")
	
func _process(delta):
	for area in get_overlapping_areas():
		if area.is_in_group("wires"):
			area.set_all_bit(bit)
#			get_tree().call_group(area.group_name, "set_bit", bit)
#		if area.bit != bit:
#			set_bit(area.bit)


		Singleton.set_color(self)


func _input(event):
	if event.is_action_pressed("escape"):
		grabbed = false

func _on_TextureButton_pressed():
	toggle()
	
func set_bit(new_bit):
	bit = new_bit

func toggle():
	if bit:
		bit = false
	else:
		bit = true

#func set_color():
	#if !bit:
		#modulate.r = 255
		#modulate.b = 0
	#else:
		#modulate.r = 0
		#modulate.b = 255
	

func _on_Timer_timeout():
	if old_bit != bit:
		toggle()
		old_bit = bit
	
func set_grab():
	grabbed = true
	
func _physics_process(delta):
	if grabbed:
		position = get_global_mouse_position()
