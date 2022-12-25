extends ColorRect

func set_logic():

	$Out.bit = 	!($In1.bit or $In2.bit)
#	print($In1.bit, " " , $In2.bit, " ",$Out.bit)

func _physics_process(delta):
	set_logic()
