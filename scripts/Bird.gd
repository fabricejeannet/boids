extends KinematicBody2D
class_name Bird 

var number:int
var motion:Vector2
var birds_in_sight = []


var margin:int

export var speed = 1.2
export var turn_factor = 1.0
export var centering_factor:float = 0.05
export var avoid_factor:float = 0.5
export var min_distance = 50

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
	compute_motion()
	avoid_other_boids()

	keep_within_bounds()
	move_local_x(motion.normalized().x * speed)
	move_local_y(motion.normalized().y * speed)
#func _draw():	
#	draw_line(position, motion.normalized() , Color.white)
##

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


func _on_Sigth_body_exited(body):
	if body != self :
		birds_in_sight.remove(birds_in_sight.find(body))
	
	
func compute_motion():
	var x_sum = 0.0
	var y_sum = 0.0
	for bird in birds_in_sight:
		x_sum += bird.position.x
		y_sum += bird.position.y
	
	if birds_in_sight.size() > 0 :	
		var center_of_mass = Vector2 (x_sum / float(birds_in_sight.size()), y_sum / float(birds_in_sight.size()))
		motion = Vector2((center_of_mass.x - position.x) * centering_factor, (center_of_mass.y - position.y) * centering_factor)
		rotate(get_angle_to(center_of_mass))

func avoid_other_boids():
	var move_x = 0.0
	var move_y = 0.0
	for bird in birds_in_sight:
		if bird.position.distance_to(self.position) < min_distance:
			move_x += self.position.x - bird.position.x
			move_y += self.position.y - bird.position.y
		motion.x += move_x * avoid_factor
		motion.y += move_y * avoid_factor
		
