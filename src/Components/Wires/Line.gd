class_name CordLine extends Area2D
#The most important and the only node that can
#transfer bits between objects. Wires are ther only
#object that can propagate information, because there
#could cause conflicts, if other objects start transfering
#information.

#center of the left square
var center1 : Vector2
var center2 : Vector2
var thickness : float = 5
onready var polyC = $CollisionPolygon2D
onready var polyR = $ColorRect
var line_index = 0
var current_line_index = 0
var theta_before : int = 1000 #some randome number
var steps = 15 # Steps for line angles so it isn't continuous
var theta
var bit = false
var old_bit = true
var group_name
var has_absolute = false
var grabbed = false
var overlapping_absolute_nodes = []


var poly : PoolVector2Array

signal grabbed

func _ready():

		add_to_group("switchable")
		add_to_group("wires")

func init(last_center, new_group_name):
	center1 = last_center
	group_name = new_group_name
	
func set_bit(newbit):
	if Singleton.count % 100 == 0:
		print("setbit")

	bit = newbit
	if old_bit != newbit:	
		Singleton.set_color(self)
		old_bit = newbit

func set_poly():
	var mouse_pos = get_global_mouse_position()
	var theta_deg = rad2deg(get_angle_to(mouse_pos - center1))
	var theta_int = int(round(theta_deg/steps))*steps

	if theta_int != theta_before:
		theta = deg2rad(theta_int)
	var vec = abs(mouse_pos.distance_to(center1)) * Vector2(cos(theta), sin(theta))
	theta_before = theta_int
	center2 = vec + center1
	
	var poly = get_poly(center1, center2, vec, theta)

	polyC.set_polygon(poly)
	polyR.set_polygon(poly)
	
func get_poly(center1, center2, vec, theta):
	var p1 = thickness*Vector2(cos(theta + PI/2), sin(theta + PI/2)) + center1
	var p2 = thickness*Vector2(-cos(theta + PI/2), -sin(theta + PI/2)) + center1
	var p3 = thickness*Vector2(cos(theta + PI/2), sin(theta + PI/2)) + center2
	var p4 = thickness*Vector2(-cos(theta + PI/2), -sin(theta + PI/2)) + center2
	poly = PoolVector2Array([p3,p1,p2,p4]) 
	return poly

signal send_bit(new_bit)

func set_all_bit(new_bit):
	emit_signal("send_bit", new_bit)

func add_absolute():
	has_absolute = true
	
func delete_absolute():
	has_absolute = false

func update_last_line():
	if get_index() == current_line_index:
		set_poly()
		
func _physics_process(delta):
	if Singleton.count % 100 == 0: # to not call so often
		print(bit)
		delete_absolute()
		overlapping_absolute_nodes = []
		for area in get_overlapping_areas():
			if area.is_in_group("absolute"):
				add_absolute()
				overlapping_absolute_nodes.append(area)

	for area in get_overlapping_areas():
		if area.is_in_group("inputs"):
			area.set_bit(bit)
			
	for area in get_overlapping_areas():
		if area.is_in_group("absolute"):
			set_all_bit(area.bit)
			return

func set_grab():
	emit_signal("grabbed")
	grabbed = true


