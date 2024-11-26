extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_RADIUS = 5
var current_rotation = Vector2(180,180)
var rota = 0.0
var is_possessing = false
var possessed_obj : CharacterBody3D
var energy : int = 10



func unpossess():
	is_possessing = false
	visible = true
	reparent(get_parent().get_parent())
	
### checks if the player can still go on or not, if the energy is less than or equal to 0 the player simply dies
func check_energy_level():
	if energy <=0:
		$AnimationPlayer.play("dying")
	pass	
	
func got_attacked():
	
	#play some effect when attacked
	energy -=1
	#animate the UI
	
	pass	
func possess_me(possessed_body: CharacterBody3D):
	is_possessing=true
	possessed_obj = possessed_body
	look_at(possessed_body.global_position)
	reparent(possessed_body)
	visible=false
	$AnimationPlayer.play("posessing")
	possessed_body.is_possessed=true
	energy -=1
	$Control/AnimatedSprite2D.play("reduce_energy")
	pass
	
	
func _ready():
	
	Input.mouse_mode =Input.MOUSE_MODE_CAPTURED

func movement(_delta : float):
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

func possession_ui(turn: bool):
	$Control.visible = turn
	pass
func _input(event):
	
	if event is InputEventMouseMotion:
		

		
		
		rota += (event as InputEventMouseMotion).screen_relative.x
		
		$Camera3D.position.x = cos(deg_to_rad((rota)*0.5)) * ROTATION_RADIUS
		$Camera3D.position.z = sin(deg_to_rad((rota)*0.5)) * ROTATION_RADIUS
		
	
		$Camera3D.look_at($CollisionShape3D/MeshInstance3D.global_position)
		pass
		
	pass


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"posessing":
			possessed_obj.set_physics_process(true)
		"dying":
			get_tree().reload_current_scene()
			pass
