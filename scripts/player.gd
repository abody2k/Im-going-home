extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func movement(delta : float):
	
	var fb= Input.get_axis("forward","backward")
	var lr = Input.get_axis("left","right")
	velocity.z = fb * SPEED
	velocity.x = lr * SPEED
	move_and_slide()
	
	
	#rotate the 3D model
	#play movement animation
	pass

func _physics_process(delta):
		movement(delta)
