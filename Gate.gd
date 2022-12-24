extends ColorRect

func set_logic():

	$Out.bit = 	!($Inp1.bit or $Inp2.bit)
#	print($Inp1.bit, " " , $Inp2.bit, " ",$Out.bit)

func _physics_process(delta):
	set_logic()
