class_name CordLine extends Area2D

#center of the left square
var center1 : Vector2
var thickness : float
onready var polyC = $CollisionPolygon2D
onready var polyR = $ColorRect
var self_index = 0

var poly : PoolVector2Array

func _ready():
	center1 = get_global_mouse_position()
#	poly = PoolVector2Array([center1+Vector2(thickness, 0), center1 - Vector2(thickness,0)])


func set_poly():
	var center2 = get_global_mouse_position()
	var theta = get_angle_to(center2 - center1)
	var p1 = thickness*Vector2(cos(theta + PI/2), sin(theta + PI/2)) + center1
	var p2 = thickness*Vector2(-cos(theta + PI/2), -sin(theta + PI/2)) + center1
	
	var p3 = thickness*Vector2(cos(theta + PI/2), sin(theta + PI/2)) + center2
	var p4 = thickness*Vector2(-cos(theta + PI/2), -sin(theta + PI/2)) + center2
	poly = PoolVector2Array([p3,p2,p1,p4]) 
	polyC.set_polygon(poly)
	polyR.set_polygon(poly)

func _physics_process(delta):
	if get_index() == self_index:
		set_poly()
