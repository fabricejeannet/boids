extends RigidBody2D
class_name Bird_RB

var number
export var speed:int = 20

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var xpos = rng.randi_range(0,int(get_viewport().size.x))
	var ypos = rng.randi_range(0, int(get_viewport().size.y))
	position = Vector2(xpos, ypos)

func set_number(n:int) -> void :
	number = n
	$Label.text = str(number)


func _physics_process(delta):
	apply_impulse(get_parent().center_of_mass, Vector2(1.0, 1.0))
#	rotate(get_angle_to(get_parent().center_of_mass))
#	move_and_slide((get_parent().center_of_mass - position).normalized() * speed)
##	move_and_collide((get_parent().center_of_mass - position).normalized() * speed)
	get_parent().compute_center_of_mass()


func _on_Sigth_body_entered(body):
	pass
#	print("Bird #" + str(number) + " rotates toward bird #" + str(body.number))
#	rotation = body.rotation * -1
