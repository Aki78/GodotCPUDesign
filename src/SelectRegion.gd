extends Area2D

var po
var p1
var co

var mouse_down = false


var all_selected = []

func _input(event):
	if event.is_action_pressed("left_click"):
		mouse_down = true
		$ColorRect3.show()
		$CollisionShape2D.show()
		po = get_global_mouse_position()
		print(po)
	elif event.is_action_released("left_click"):
		all_selected = []
		mouse_down = false
		$ColorRect3.hide()
		$CollisionShape2D.hide()
	if event.is_action_pressed("visual") and Singleton.mode == "normal":
		Singleton.mode = "visual"
	if event.is_action_pressed("delete") and Singleton.mode == "visual":
		for _i in get_overlapping_areas():
			_i.queue_free()

func _process(delta):
	if Singleton.mode == "visual":
		if mouse_down:
			p1 =get_global_mouse_position()
			print(p1)
			var diff = p1-po
			co = get_global_mouse_position() - diff
			$ColorRect3.rect_size = 2*(p1 - po)
			$ColorRect3.rect_global_position = po - $ColorRect3.rect_size/2
			
			if $ColorRect3.rect_size[0]> 1 and $ColorRect3.rect_size[1]>1:

				$CollisionShape2D.shape.extents = (p1 - po)
				$CollisionShape2D.global_position = co
			else:
				$CollisionShape2D.shape.extents = Vector2(0,0)
				$CollisionShape2D.global_position = Vector2(10000000, 10000000)


