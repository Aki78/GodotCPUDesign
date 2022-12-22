extends Area2D


var bit = true

func _ready():
	pass 
	
func _process(delta):
	for area in get_overlapping_areas():
		get_tree().call_group(area.group_name, "set_bit", bit)

func _on_TextureButton_pressed():
	if bit:
		bit = false
		modulate.r = 255
		modulate.b = 0
	else:
		bit = true
		modulate.r = 0
		modulate.b = 255
