extends Area2D

var inp_text : String = "nand"
var grabbed = false

onready var out = $Areas/Outputs/Out


onready var in1 = $Areas/Inputs/In1
onready var in2 = $Areas/Inputs/In2

onready var inE = $Areas/Inputs/InE
var inputs 
var outputs
var in1_pos

var bit = false

func _ready():
	add_to_group("gate")
	in1_pos = in1.position
	inputs = get_node("Areas").get_node("Inputs")
	outputs = get_node("Areas").get_node("Outputs")
	set_shape()
	$CollisionShape.scale.y = 2
	$CollisionShape.scale.x = 2
	$CollisionShape.position.y = position.y - 22

func set_shape():
	$Label.text = ""
	if not in2.is_visible():
		set_two()
	if inp_text == "not":
		out.bit = !in1.bit
		set_not()
	if inp_text == "nand":
		pass
	elif inp_text == "and":
		pass
	elif inp_text == "or":
		pass
	elif inp_text == "not":
		pass
	elif inp_text == "nor":
		pass
	elif inp_text == "bit":
		pass
	elif inp_text == "byte":
		rescale()
		byte_mem()
	else:
		unscale()
		$Label.text = "error"
		
func set_logic():
	if inp_text == "nand":
		out.bit = !(in1.bit and in2.bit)
	elif inp_text == "and":
		out.bit = (in1.bit and in2.bit)
	elif inp_text == "or":
		out.bit = (in1.bit or in2.bit)
	elif inp_text == "not":
		out.bit = !in1.bit
	elif inp_text == "nor":
		out.bit = !(in1.bit or in2.bit)
	elif inp_text == "bit":
		out.bit = bit_mem()
	elif inp_text == "byte":
		byte_mem()

func rescale():
	$CollisionShape.scale.y = 8
	$CollisionShape.scale.x = 2
	$CollisionShape.position.y = position.y + 38
	$GateRect.rect_scale.y = 4

	for i in range(outputs.get_child_count()):
		inputs.get_child(i).position.x = position.x - 50.5
		inputs.get_child(i).position.y = i*position.y - 13.5
		inputs.get_child(i).show()
		outputs.get_child(i).position.x = position.x + 9
		outputs.get_child(i).position.y = i*position.y - 13.5
		outputs.get_child(i).show()
	inE.position.x = position.x -21.5
	inE.position.y = position.y + 128
	inE.show()

func unscale():
	$CollisionShape.scale.y = 2
	$CollisionShape.scale.x = 2
	$CollisionShape.position.y = position.y - 22
	$GateRect.rect_scale.y = 1

	for i in range(outputs.get_child_count()):
		if i > 0:
			if i > 1:
				inputs.get_child(i).hide()
			outputs.get_child(i).hide()
	inputs.get_child(inputs.get_child_count() - 1).hide()
	out.position.y = position.y - 22
	

func _physics_process(delta):
	set_logic()
	if Singleton.mode == "grab" and grabbed:
		position = get_global_mouse_position() + Vector2(0, 10)
	elif Singleton.mode == "rotate":
		for area in get_overlapping_areas():
			if area.name == "MouseTip":
				var theta = get_angle_to(get_global_mouse_position())
				print(theta)
				rotate(theta)
	else:
		grabbed = false
		

func set_not():
	#highly suboptimal
	in2.hide()
	in1.position = out.position - Vector2(57.5,0)
	
func set_two():
	#highly suboptimal
	in2.show()
	in1.position = in1_pos
	
func bit_mem():
	if in2.bit:
		bit = in1.bit
	return bit
		

func byte_mem():
	if inE.bit:
		for i in range(outputs.get_child_count()):
			outputs.get_child(i).bit = inputs.get_child(i).bit
		

func _input(event):
	
	if event.is_action_pressed("rotate_gate") and Singleton.mode == "normal":
		Singleton.mode = "rotate"

func _on_LineEdit_text_changed(new_text):
	inp_text = new_text
	set_shape()

func set_grab():
	grabbed = true
	

