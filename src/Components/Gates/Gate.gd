extends Area2D

var inp_text : String = "nor"
var grabbed = false

onready var out = $Areas/Out
onready var in1 = $Areas/In1
onready var in2 = $Areas/In2
var in1_pos

func _ready():
	add_to_group("gate")
	in1_pos = in1.position

func set_logic():
	$Label.text = ""
	if not $Areas/In2.is_visible():
		set_two()
	if inp_text == "nand":
		out.bit = !(in1.bit and in2.bit)
	elif inp_text == "and":
		out.bit = (in1.bit and in2.bit)
	elif inp_text == "or":
		out.bit = (in1.bit or in2.bit)
	elif inp_text == "not":
		out.bit = !in1.bit
		set_not()
	elif inp_text == "nor":
		out.bit = !(in1.bit or in2.bit)
	else:
		$Label.text = "error"

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
	$Areas/In2.hide()
	$Areas/In1.position = $Areas/Out.position - Vector2(57.5,0)
	
func set_two():
	#highly suboptimal
	$Areas/In2.show()
	$Areas/In1.position = in1_pos
	
func _input(event):
	
	if event.is_action_pressed("rotate_gate") and Singleton.mode == "normal":
		Singleton.mode = "rotate"


#		Singleton.mode = "normal"


func _on_LineEdit_text_changed(new_text):
	inp_text = new_text

func set_grab():
	grabbed = true
	

