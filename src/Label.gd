extends Label

var mode_before = "normal"
onready var center = OS.get_window_size()/2

var mode = " mode"

func _ready():
	text = "normal Mode"




func _process(delta):
	# just to optimize speed so it doesn't run every process
	if mode_before == Singleton.mode:
		return
	text = Singleton.mode + mode
		
	mode_before = Singleton.mode
	
	
	
