extends CharacterBody3D

enum SOLIDER_TYPE {STATIC, DYNAMIC}
@export var pos : Array[Node3D]
@export var solider_type : SOLIDER_TYPE
@export var dynamic_movement_time : float = 10.0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var is_possessed = false
var can_it_be_possessed = false
var tween1 : Tween 
var tween2 : Tween
var player : CharacterBody3D


func go_backward():
	tween2 = get_tree().create_tween()
	look_at(pos[1].global_position)
	tween2.tween_property(self,"global_position",pos[1].global_position,dynamic_movement_time)
	tween2.finished.connect(go_forward)

func go_forward():
	tween1 = get_tree().create_tween()
	look_at(pos[0].global_position)
	tween1.tween_property(self,"global_position",pos[0].global_position,dynamic_movement_time)
	tween1.finished.connect(go_backward)
	
	
func _ready():
	
	if solider_type != SOLIDER_TYPE.STATIC:
		go_forward()

func collapse_character():
	
	$AnimationPlayer.play("collapsing")
	player.call("unpossess")
	is_possessed=false
	can_it_be_possessed=false
	pass
		#TODO LEAVE this body
		#play collapsing animation
		#change

func possess():
	solider_type = SOLIDER_TYPE.STATIC
	if tween1:
		
		tween1.kill()
	if tween2:
		tween2.kill()
	is_possessed = true
	
	
	
	
	
func movement(_delta : float):
	
	if is_possessed:
		
		if Input.is_action_just_pressed("action"):
			collapse_character()
			return
			
		var fb = Input.get_axis("forward","backward")
		var lr = Input.get_axis("left","right")
		
		$AnimationPlayer.play("movement")
		velocity = basis.z * SPEED * fb
		rotate_y(deg_to_rad(lr * SPEED))
		move_and_slide()
		
	
	
func _physics_process(delta):
	
	
	movement(delta)
	
	
	if can_it_be_possessed and is_possessed == false and Input.is_action_just_pressed("action"):
		print("possessed successfully")
		player.call("possess_me",self)
		possess()
		set_physics_process(false)
		pass
	pass


func _on_animation_player_animation_finished(anim_name):

	if anim_name == "collapsing":
		$Area3D.queue_free()
		player = null
		process_mode=PROCESS_MODE_DISABLED
		is_possessed= false
		pass
	pass # Replace with function body.


func player_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	(body as CharacterBody3D).call("possession_ui",true)
	can_it_be_possessed=true
	player = body
	#TODO
	#view possession menu
	pass # Replace with function body.




func player_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	(body as CharacterBody3D).call("possession_ui",false)
	can_it_be_possessed=false
	player = body
	#TODO
	#HIDE POSSESSION MENU
	pass # Replace with function body.
