extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_RADIUS = 5
var current_rotation = Vector2(180,180)
var rota = 0.0


func _ready():
	Input.mouse_mode =Input.MOUSE_MODE_CAPTURED

func movement(delta : float):
	
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
		
		#$Camera3D.position.x = cos((event as InputEventMouseMotion).relative.x * 0.05) * ROTATION_RADIUS
		#current_rotation +=Vector2(remap( (event as InputEventMouseMotion).screen_relative.x,-900,900,0,360),remap( (event as InputEventMouseMotion).screen_relative.y,-900,900,0,360))
		
		
		
		#current_rotation.x += (event as InputEventMouseMotion).screen_relative.x
		#current_rotation.x = clampf(current_rotation.x,0,460)
		#current_rotation.y += (event as InputEventMouseMotion).screen_relative.y
		#current_rotation.y = clampf(current_rotation.y,0,300)
		#$Camera3D.position.x = cos((current_rotation.x*0.005)) * ROTATION_RADIUS
		#$Camera3D.position.z = cos((current_rotation.y*0.005)) * ROTATION_RADIUS
		
		
		rota += (event as InputEventMouseMotion).screen_relative.x
		
		$Camera3D.position.x = cos(deg_to_rad((rota)*0.5)) * ROTATION_RADIUS
		$Camera3D.position.z = sin(deg_to_rad((rota)*0.5)) * ROTATION_RADIUS
		
		
		#$Camera3D.position.z = sin(deg_to_rad(current_rotation.y)) * ROTATION_RADIUS
		print(rota)
		print($Camera3D.position)
		#$Camera3D.position.z = cos((event as InputEventMouseMotion).relative.y * 0.05) * ROTATION_RADIUS
		$Camera3D.look_at($CollisionShape3D/MeshInstance3D.global_position)
		pass
		
	pass
