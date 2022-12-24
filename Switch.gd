extends Area2D

var bit = true
var old_bit = false

func _ready():
	add_to_group("switch")
	add_to_group("switchable")
	
func _process(delta):
	for area in get_overlapping_areas():
		if area.is_in_group("wires"):
			get_tree().call_group(area.group_name, "set_bit", bit)
#		if area.bit != bit:
#			set_bit(area.bit)


		set_color()


func _on_TextureButton_pressed():
	toggle()
	print(get_overlapping_areas())
	
func set_bit(new_bit):
#	print(new_bit)
	bit = new_bit

func find_match(text, list):
	print(list)
	for _i in list:
		if text in _i:
#			print(_i)
			return _i

func toggle():
	if bit:
		bit = false
	else:
		bit = true


func set_color():
	if !bit:
		modulate.r = 255
		modulate.b = 0
	else:
		modulate.r = 0
		modulate.b = 255
	

func _on_Timer_timeout():
	if old_bit != bit:
		toggle()
		old_bit = bit
	

	