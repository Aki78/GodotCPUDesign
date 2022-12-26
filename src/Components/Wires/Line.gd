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
var current_index = 0
var theta_before : int = 1000 #some randome number
var steps = 15 # Steps for line angles so it isn't continuous
var theta
var bit
var old_bit = true
var group_name
var has_absolute = false
var grabbed = false

var poly : PoolVector2Array

signal grabbed

func _ready():
	add_to_group("switchable")
	add_to_group("wires")

func init(last_center, new_group_name):
	center1 = last_center
	group_name = new_group_name
	
func set_bit(newbit):
	bit = newbit
	Singleton.set_color(self)

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

func add_all_absolutes():
#	print("ADDING ALL SWITCHES!")
	get_tree().call_group(group_name, "add_absolute")
func delete_all_absolutes():
#	print("ADDING ALL SWITCHES!")
	get_tree().call_group(group_name, " delete_absolute")


func set_all_bit(new_bit):
	get_tree().call_group(group_name, "set_bit", new_bit)


func add_absolute():
	has_absolute = true
	
func delete_absolute():
	has_absolute = false

func _physics_process(delta):
	if get_index() == current_index:
		set_poly()
	delete_all_absolutes()
	for area in get_overlapping_areas():
		if area.is_in_group("absolute"):
			add_all_absolutes()
			set_all_bit(area.bit)
		if area.is_in_group("out"):
#			print("hit", area.bit, bit)
#			add_all_absolutes()
			set_all_bit(area.bit)
#	for area in get_overlapping_areas():
#		if area.is_in_group("contact"):
#			area.bit = bit


func _on_Line_area_entered(area):
	if area.is_in_group("absolute"):
		has_absolute = true


func _on_Line_area_exited(area):
	if area.is_in_group("absolute"):
		has_absolute = false

func set_grab():
	emit_signal("grabbed")
	grabbed = true


