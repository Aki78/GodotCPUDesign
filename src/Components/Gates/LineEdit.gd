extends LineEdit


func _ready():
	text = "nand" 
	editable = false
	add_to_group("inputs")
func _input(event):
	
	if event.is_action_pressed("input") and Singleton.mode == "normal":
		Singleton.mode = "input"
		get_tree().call_group("inputs", "make_editability", true)
	if event.is_action_pressed("escape") and Singleton.mode == "input":
		get_tree().call_group("inputs", "make_editability", false)
#		Singleton.mode = "normal"

func make_editability(e):
	print("making editable")
	editable = e

