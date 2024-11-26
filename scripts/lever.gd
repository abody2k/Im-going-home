extends AnimatableBody3D

var player : CharacterBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Control.visible and Input.is_action_just_pressed("action") and !$AnimationPlayer.is_playing():
		player.global_position = Vector3($player_position.global_position.x,player.global_position.y,$player_position.global_position.z)
		player.call("pull_lever")
		$AnimationPlayer.play("bring_it_down")
		


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body as CharacterBody3D).get("is_possessed"):
		$Control.visible=true
		body.call("disable_depossessing",true)
		player=body


func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body as CharacterBody3D).get("is_possessed"):
		$Control.visible=false
		body.call("disable_depossessing",false)
		player=null


func _on_animation_player_animation_finished(anim_name):
	$Control.visible=false
	player.call("disable_depossessing",false)
	process_mode = PROCESS_MODE_DISABLED
	$Area3D.queue_free()
	
