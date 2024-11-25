extends CharacterBody3D

enum SOLIDER_TYPE {STATIC, DYNAMIC}
@export var pos : Array[Node3D]
@export var solider_type : SOLIDER_TYPE
@export var dynamic_movement_time : float = 10.0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var is_possessed = false


func go_backward():
	var tween = get_tree().create_tween()
	tween.finished.connect(go_forward)
	look_at(pos[1].global_position)
	tween.tween_property(self,"global_position",pos[1].global_position,dynamic_movement_time)

func go_forward():
	var tween = get_tree().create_tween()
	tween.finished.connect(go_backward)
	look_at(pos[0].global_position)
	tween.tween_property(self,"global_position",pos[0].global_position,dynamic_movement_time)
	
func _ready():
	
	if solider_type != SOLIDER_TYPE.STATIC:
		go_forward()

func collapse_character():
	pass
		#TODO LEAVE this body
		#play collapsing animation
		#change
func movement(delta : float):
	
	if is_possessed:
		
		if Input.is_action_just_pressed("action"):
			collapse_character()
			
		var fb = Input.get_axis("forward","backward")
		var lr = Input.get_axis("left","right")
		if fb != 0 or lr !=0 :
			pass
			#PLAY CERTAIN ANIMATION
			
			
			
		pass

		
		
		
		pass
	pass
	
	
func _physics_process(delta):
	pass
