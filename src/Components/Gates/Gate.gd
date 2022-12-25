extends Area2D

var inp_text : String = "nor"
var grabbed = false

onready var out = $Areas/Out
onready var in1 = $Areas/In1
onready var in2 = $Areas/In2

func _ready():
	add_to_group("gate")

func set_logic():
	$Label.text = ""
	if inp_text == "nor":
		out.bit = !(in1.bit or in2.bit)
	elif inp_text == "and":
		out.bit = (in1.bit and in2.bit)
	elif inp_text == "or":
		out.bit = (in1.bit or in2.bit)
	else:
		$Label.text = "error"

func _physics_process(delta):
	set_logic()
	if Singleton.mode == "grab" and grabbed:
		position = get_global_mouse_position() + Vector2(0, 10)
	else:
		grabbed = false



func _on_LineEdit_text_changed(new_text):
	inp_text = new_text

func set_grab():
	grabbed = true
	

