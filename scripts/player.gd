extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_RADIUS = 5
var current_rotation = Vector2(180,180)
var rota = 0.0
var is_possessing = false


func _ready():
	Input.mouse_mode =Input.MOUSE_MODE_CAPTURED

func movement(delta : float):
	if is_possessing:
		return
	
	var fb = Input.get_axis("forward","backward")
	
	var lr = Input.get_axis("left","right")
	velocity =$CollisionShape3D.basis.z * SPEED * fb
	$CollisionShape3D.rotate_y(deg_to_rad(lr * SPEED))
	move_and_slide()
	
	

	
	#rotate the 3D model
	#play movement animation
	pass

func _physics_process(delta):
		movement(delta)


func _input(event):
	
	if event is InputEventMouseMotion:
		print((event as InputEventMouseMotion).screen_relative)
		

		
		
		rota += (event as InputEventMouseMotion).screen_relative.x
		
		$Camera3D.position.x = cos(deg_to_rad((rota)*0.5)) * ROTATION_RADIUS
		$Camera3D.position.z = sin(deg_to_rad((rota)*0.5)) * ROTATION_RADIUS
		
		
		#print(rota)
		#print($Camera3D.position)
		$Camera3D.look_at($CollisionShape3D/MeshInstance3D.global_position)
		pass
		
	pass
