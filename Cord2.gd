class_name CordLine extends Area2D

#center of the left square
var center1 : Vector2
var center2 : Vector2
var thickness : float = 5
onready var polyC = $CollisionPolygon2D
onready var polyR = $ColorRect
var current_index = 0
var theta_before : int = 1000 #some randome number
var steps = 15
var theta
var bit
var old_bit = true
var group_name

var poly : PoolVector2Array

func _ready():
	pass

func init(last_center, new_group_name):
	center1 = last_center
	group_name = new_group_name
	

func set_bit(newbit):
	bit = newbit
#	if old_bit != bit:
	if bit:
		$ColorRect.modulate.r = 0
		$ColorRect.modulate.b = 255
	else:
		$ColorRect.modulate.r = 255
		$ColorRect.modulate.b = 0
	
#	print(bit)

func set_poly():
	var mouse_pos = get_global_mouse_position()
	var theta_deg = rad2deg(get_angle_to(mouse_pos - center1))
	var theta_int = int(round(theta_deg/steps))*steps


	if theta_int != theta_before:
		theta = deg2rad(theta_int)
	var vec = abs(mouse_pos.distance_to(center1)) * Vector2(cos(theta), sin(theta))
	theta_before = theta_int

	var p1 = thickness*Vector2(cos(theta + PI/2), sin(theta + PI/2)) + center1
	var p2 = thickness*Vector2(-cos(theta + PI/2), -sin(theta + PI/2)) + center1
	center2 = vec + center1
	var p3 = thickness*Vector2(cos(theta + PI/2), sin(theta + PI/2)) + center2
	var p4 = thickness*Vector2(-cos(theta + PI/2), -sin(theta + PI/2)) + center2
	poly = PoolVector2Array([p3,p1,p2,p4]) 
	polyC.set_polygon(poly)
	polyR.set_polygon(poly)

func _physics_process(delta):
	if get_index() == current_index:
		set_poly()
