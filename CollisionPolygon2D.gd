extends CollisionPolygon2D


func _ready():
	# Get the current mouse position
	var mouse_position = get_viewport().get_mouse_position()
#	var new_shape : PoolVector2Array
	set_polygon([Vector2(100, 100), Vector2(200, 100)])
	

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
#			var mouse_position = get_global_mouse_position()
#			var halfY = Vector2(0,50)
#			set_polygon( PoolVector2Array([mouse_position + halfY]) + polygon)
#			set_polygon( polygon  + PoolVector2Array([mouse_position - halfY]))
##			set_polygon( PoolVector2Array([mouse_position]) + polygon)
#			print(polygon)
#		else:
#			print("World")
#

