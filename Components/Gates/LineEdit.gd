extends LineEdit


func _ready():
	text = "nor" 
	editable = false
func _input(event):
	
	if event.is_action_pressed("input") and Singleton.mode == "normal":
		Singleton.mode = "input"
		editable = true
	if event.is_action_pressed("escape"):
		editable = false


