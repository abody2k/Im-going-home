extends CharacterBody3D

enum SOLIDER_TYPE {STATIC, DYNAMIC}
enum MODES {OBSERVING, ATTACKING}
@export var pos : Array[Node3D]
@export var solider_type : SOLIDER_TYPE
@export var dynamic_movement_time : float = 10.0
const BULLET = preload("res://scenes/bullet.tscn")
const ATTACKING_RANGE = 100
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var is_possessed = false
var can_it_be_possessed = false
var tween1 : Tween 
var tween2 : Tween
var player : CharacterBody3D
var mode : MODES = MODES.OBSERVING
@export var authority = 0
const STAR = preload("res://scenes/star.tscn")
var made_stars = false
var depossessing = false

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
	
	if made_stars:
		return
	print('done')
	print(authority)
	print(range(authority))
	for i in range(authority):
		print(i)
		var star = STAR.instantiate()
		$stars.add_child(star)
		star.position=Vector3.ZERO + Vector3(i,0,0)
	made_stars=true

func collapse_character():
	
	$AnimationPlayer.play("collapsing")
	player.call("unpossess")
	is_possessed=false
	can_it_be_possessed=false
	pass


func possess():
	solider_type = SOLIDER_TYPE.STATIC
	if tween1:
		
		tween1.kill()
	if tween2:
		tween2.kill()
	is_possessed = true
	
	
	
func on_alert():
	
	#
	pass
	
func movement(_delta : float):
	
	if is_possessed:
		
		if Input.is_action_just_pressed("action") and !depossessing:
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
		player.call("possess_me",self)
		possess()
		set_physics_process(false)
		pass
	pass
	
	
	if mode == MODES.ATTACKING:
		look_at(player.global_position)




func attack():
	$AnimationPlayer.play("Attack")
	pass






func _on_animation_player_animation_finished(anim_name):

	match anim_name:
		"collapsing":
			$Area3D.queue_free()
			player = null
			process_mode=PROCESS_MODE_DISABLED
			is_possessed= false
		"Attack":
			
			var bullet = BULLET.instantiate()
			
			
			get_tree().root.add_child((bullet))
			bullet.global_position = $aim.global_position
			bullet.set_player_position(player.global_position)
			#ATTACK LOGIC
			#RELOAD
			#ATTACK AGAIN
			$reload.start()
			pass


func player_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	print(body)
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


func _on_player_observed(_body_rid, body, _body_shape_index, _local_shape_index):
	
	#stop moving
	if tween1:
		tween1.kill()
	if tween2:
		tween2.kill()
		
		
	player = body
	mode = MODES.ATTACKING
	attack()
	
	
	pass # Replace with function body.

func disable_depossessing(depos:bool):
	depossessing=depos
func _on_reload_timeout():
	
	#is player in range ? if so attack again, else go back to normal mode
	
	if global_position.distance_squared_to(player.global_position) <= ATTACKING_RANGE:
		attack()
	else:
		player = null
		mode = MODES.OBSERVING
		_ready()
	
	pass # Replace with function body.
