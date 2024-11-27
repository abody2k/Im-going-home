extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var fuel = 100.0
var compass : TextureRect
var dist : RichTextLabel
var planet : AnimatableBody2D
var fuel_ui
func _ready():
	fuel_ui = get_parent().get_node("CanvasLayer2/Control/fuel")
	compass = (get_parent().get_node("CanvasLayer2/Control/circle/compass") as TextureRect)
	dist = get_parent().get_node("CanvasLayer2/Control/RichTextLabel")
	planet = get_parent().get_node("AnimatableBody2D")
	
var temp_pos : Vector2
	
func _physics_process(delta):
	temp_pos = (planet.global_position - global_position)
	compass.rotation_degrees = rad_to_deg(atan2(temp_pos.y,temp_pos.x))+90
	dist.text = "Contact distance : " + str(global_position.distance_squared_to(planet.global_position)-50000)
	
	if fuel > 0:
		if Input.is_action_pressed("action"):
			velocity= transform.x * SPEED
			fuel -= 2 * delta
			fuel_ui.value-=2 * delta
		else:
			fuel_ui.value-= delta
			fuel -= delta
		
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	rotate(deg_to_rad(direction * delta*30))

	move_and_slide()
