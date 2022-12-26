extends Area2D
#Switch node, that toggles between on and off.
#Group 'absolute' means that only one can exist
#on a wire, otherwise there will be a conflic.

var bit = true
var old_bit = false
var grabbed = false

func _ready():
	add_to_group("switch")
	add_to_group("switchable")
	add_to_group("absolute")
	
func _process(delta):
		Singleton.set_color(self)

func _input(event):
	if event.is_action_pressed("escape"):
		grabbed = false

func _on_TextureButton_pressed():
	toggle()
	
func set_bit(new_bit):
	bit = new_bit

func toggle():
	if bit:
		bit = false
	else:
		bit = true

func _on_Timer_timeout():
	if old_bit != bit:
		toggle()
		old_bit = bit
	
func set_grab():
	grabbed = true
	
func _physics_process(delta):
	if grabbed:
		position = get_global_mouse_position()
