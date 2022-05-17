extends Node2D

var Bird = preload("res://scenes/Bird.tscn")
var Bird_RB = preload("res://scenes/Bird_RB.tscn")

var center_of_mass:Vector2
var manual_center_of_mass:bool = false

export var bird_count:int = 10
export var margin:int = 200

func _ready():
	for n in bird_count:
		var bird = Bird.instance()
		bird.set_number(n)
		add_child(bird)


func _draw():
	draw_rect(Rect2(Vector2(margin, margin), Vector2(get_viewport().size.x - 2 * margin, get_viewport().size.y - 2 * margin)), Color.white, false)

#func _process(delta):
#	if not manual_center_of_mass :
#		center_of_mass = compute_center_of_mass()
#		update()


#func compute_center_of_mass():
#	var center_of_mass:Vector2
#	var x_sum = 0
#	var y_sum = 0
#	for bird in get_children():
#		x_sum += bird.position.x
#		y_sum += bird.position.y
#	center_of_mass = Vector2 (x_sum / get_child_count(), y_sum / get_child_count())
#	return center_of_mass
#
#
#func _draw():
#	var c = Color.red
#	if manual_center_of_mass :
#		c = Color.green
#	draw_circle(center_of_mass, 10, c)
#
#
#func _unhandled_input(event):
#	if event is InputEventMouseButton:
#		manual_center_of_mass = true
#		center_of_mass = get_global_mouse_position()
#		update()
