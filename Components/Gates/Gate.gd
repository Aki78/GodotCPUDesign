extends Area2D

var inp_text : String = "nor"

func _ready():
	add_to_group("gate")

func set_logic():
	$Label.text = ""
	if inp_text == "nor":
		$Out.bit = !($In1.bit or $In2.bit)
	elif inp_text == "and":
		$Out.bit = ($In1.bit and $In2.bit)
	elif inp_text == "or":
		$Out.bit = ($In1.bit or $In2.bit)
	else:
		$Label.text = "error"

func _physics_process(delta):
	set_logic()


func _on_LineEdit_text_changed(new_text):
	inp_text = new_text
