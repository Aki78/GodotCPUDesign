extends Node2D

var center = Vector2(0,0)

var p1
var p2
var thickness = 0.5
var undo = false

var current_index = 0

func _ready():
	var mouse_position = get_viewport().get_mouse_position()
	$ColorRect.set_polygon([])
	

func _input(event):
	if event.is_action_pressed("new_cord"):
		current_index += 1
	if get_index() == current_index:
		if event.is_action_pressed("undo"):
			print("undo")
			var new_array = Array($ColorRect.polygon)
			new_array = new_array.slice(1,len(new_array)-2)
			print("new array:",new_array)
			$ColorRect.set_polygon(new_array)
			center = get_global_mouse_position()
	#		undo = true
		if event is InputEventMouseButton:
			if event.is_pressed():
				var rect_polygon = $ColorRect.polygon
				var mouse_position = get_global_mouse_position()
				center = mouse_position
				var halfY = Vector2(0,5)
				$ColorRect.set_polygon( PoolVector2Array([p2]) + rect_polygon)
				rect_polygon = $ColorRect.polygon
				$ColorRect.set_polygon( rect_polygon  + PoolVector2Array([p1]))
				print(rect_polygon)

func _process(delta):
	if get_index() == current_index:
		var polygon = $ColorRect.polygon
		print(polygon)
		var poly_len = len($ColorRect.polygon)
		center = get_global_mouse_position()
		var theta
		if len(polygon) > 0:
			theta = get_angle_to(get_global_mouse_position() - (polygon[1]+polygon[poly_len -2])/2 )
		else:
			theta = get_angle_to(get_global_mouse_position())
			
		p1 = thickness*Vector2(cos(theta + PI/2), sin(theta + PI/2)) + center
		p2 = thickness*Vector2(-cos(theta + PI/2), -sin(theta + PI/2)) + center

		if len(polygon) > 0:

			$ColorRect.polygon[0] = p2
			$ColorRect.polygon[poly_len -1] = p1
