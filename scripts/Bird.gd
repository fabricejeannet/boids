extends KinematicBody2D
class_name Bird 

var number:int
var motion:Vector2
var birds_in_sight = []


var margin:int

export var speed:int = 10
export var turn_factor = 1
export var centering_factor:float = 0.005

func _ready():
	margin = get_parent().margin
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var xpos = rng.randi_range(margin, int(get_viewport().size.x) - margin)
	var ypos = rng.randi_range(margin, int(get_viewport().size.y) - margin)
	position = Vector2(xpos, ypos)

func set_number(n:int) -> void :
	number = n
	$Label.text = str(number)


func _physics_process(delta):
	keep_within_bounds()
	move_and_slide(motion.normalized() * speed)


func _draw():	
	draw_line(position, motion.normalized() , Color.white)
#

func keep_within_bounds() -> void:
	if position.x < margin :
		motion.x += turn_factor	
	if position.x > get_viewport().size.x - margin :
		motion.x -= turn_factor
	if position.y < margin :
		motion.y += turn_factor
	if position.y > get_viewport().size.y - margin :
		motion.y -= turn_factor


func _on_Sigth_body_entered(body):
	if body != self :
		birds_in_sight.append(body)
		update_label()
		compute_motion()

func _on_Sigth_body_exited(body):
	if body != self :
		birds_in_sight.remove(birds_in_sight.find(body))
		update_label()
		compute_motion()
	
func update_label():
	var t = "["
#	for bird in birds_in_sight:
#		t += str(bird.number) + ", "
#	t += "]"
#	$Label.text = str(number) + t
	
func compute_motion():
	var x_sum = 0.0
	var y_sum = 0.0
	for bird in birds_in_sight:
		x_sum += bird.position.x
		y_sum += bird.position.y
		
	var center_of_mass = Vector2 (int(x_sum / float(get_child_count())), int(y_sum / float(get_child_count())))
	
	motion =  Vector2((center_of_mass.x - position.x) * centering_factor, (center_of_mass.y - position.y) * centering_factor)
	
#	for bird in birds_in_sight:
#		bird.motion = motion
