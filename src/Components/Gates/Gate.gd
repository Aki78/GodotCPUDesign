extends Area2D
#Semi-programmable gates

var inp_text : String = "nand"

var grabbed = false

onready var out = $Areas/Outputs/Out

onready var OutNode = preload("res://Components/Gates/Out.tscn")
onready var InNode = preload("res://Components/Gates/Inp.tscn")

onready var in1 = $Areas/Inputs/In1
onready var in2 = $Areas/Inputs/In2

#onready var inE = $Areas/Inputs/InE
var inputs 
var outputs
var in1_pos

var bit = true

func _ready():
	add_to_group("gate")
	in1_pos = in1.position
	inputs = get_node("Areas").get_node("Inputs")
	outputs = get_node("Areas").get_node("Outputs")
	set_shape()
	$CollisionShape.scale.y = 2
	$CollisionShape.scale.x = 2
	$CollisionShape.global_position.y = position.y

func set_shape():
	$ErrorMessage.text = ""
	if not in2.is_visible():
		set_two()
	if inp_text == "not":
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
		rescale8()
	elif inp_text == "enable":
		rescale8()
	else:
		unscale()
		$ErrorMessage.text = "error"
		
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
	elif inp_text == "enable":
		byte_enable()

func rescale8():
	$CollisionShape.scale.y = 8
	$CollisionShape.scale.x = 2
	$CollisionShape.global_position.y = position.y  #+ 38
	$GateRect.rect_global_position.y = position.y - 2*$GateRect.rect_size.y
	$GateRect.rect_scale.y = 4
	
	for i in range(7):
		var new_out = OutNode.instance()
		new_out.name = "Out"+str(i+2)
		new_out.add_to_group("absolute")
		$Areas/Outputs.add_child(new_out)
	for i in range(6):
		var new_in = InNode.instance()
		new_in.name = "In"+str(i+3)
		$Areas/Inputs.add_child(new_in)
	var inE = InNode.instance()
	inE.name = "InE"
	$Areas/Inputs.add_child(inE)

	for i in range(outputs.get_child_count()):
		inputs.get_child(i).global_position.x = position.x -30.5
		inputs.get_child(i).global_position.y = position.y + i*20 - 70
#		inputs.get_child(i).global_position.y = i*position.y
		inputs.get_child(i).show()
		outputs.get_child(i).global_position.x = position.x + 30.5
		outputs.get_child(i).global_position.y = position.y + i*20 - 70
		outputs.get_child(i).show()
	inE.global_position.x = position.x
	inE.global_position.y = position.y + 90
	inE.show()

func unscale():
	$CollisionShape.scale.y = 2
	$CollisionShape.scale.x = 2

	$GateRect.rect_scale.y = 1
	$CollisionShape.global_position.y = $GateRect.rect_global_position.y  + $GateRect.rect_size.y/2

	for i in range(8 + 1):
		if i > 2:
			if inputs.get_node("In"+str(i)):
				inputs.get_node("In"+str(i)).queue_free()
#		if outputs.name == "Out"+str(i):
		if outputs.get_node("Out"+str(i)):
			outputs.get_node("Out"+str(i)).queue_free()
	if inputs.get_node("InE"):
		inputs.get_node("InE").queue_free()
	out.global_position.y = position.y 

func _physics_process(delta):
	set_logic()
#	if get_index() == 1:
	$Icon.global_position = position
#	$Icon.position.y = sqrt(position.y)
	if Singleton.mode == "grab" and grabbed:
		position = get_global_mouse_position() + Vector2(0, 10)
	elif Singleton.mode == "rotate":
		for area in get_overlapping_areas():
			if area.name == "MouseTip":
				var theta = get_angle_to(get_global_mouse_position())
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
	var inE = $Areas/Inputs.get_node("InE")
	if inE:
		if inE.bit:
			for i in range(outputs.get_child_count()):
				outputs.get_child(i).bit = inputs.get_child(i).bit

func byte_enable():
	var inE = $Areas/Inputs.get_node("InE")
	if inE:
		if inE.bit:
			for i in range(outputs.get_child_count()):
				outputs.get_child(i).bit = inputs.get_child(i).bit
		else:
			for i in range(outputs.get_child_count()):
				outputs.get_child(i).bit = false
			

func _input(event):
	if event.is_action_pressed("rotate_gate") and Singleton.mode == "normal":
		Singleton.mode = "rotate"

func _on_LineEdit_text_changed(new_text):
	inp_text = new_text
	set_shape()

func set_grab():
	grabbed = true
	
func save():
	return [$LineEdit.text,var2str(position)]

func load_data(data):
	position = str2var(data[1])
	$LineEdit.text = data[0]
	inp_text = data[0]
	set_shape()



