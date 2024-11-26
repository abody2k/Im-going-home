extends AnimatableBody3D

@export var authority : int = 0
var door_opened = false
var player_authority : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $doorControl.visible and Input.is_action_just_pressed("action"):
		
		
		if player_authority >= authority:	
			if !$AnimationPlayer.is_playing():	
				door_opened = !door_opened
				$openDoor.play()
				if door_opened:
					$AnimationPlayer.play("close_door")
					$doorControl/Panel/RichTextLabel.text = "Click space to open the door"
				else:
					$AnimationPlayer.play("open_door")
					$doorControl/Panel/RichTextLabel.text = "Click space to close the door"
		else:
			$lockedDoor.play()
			#play locked door audio
			pass


func _on_player_detector_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if (body as CharacterBody3D).get("is_possessed"):
		$doorControl.visible=true
		player_authority = body.get("authority")
		body.call("disable_depossessing",true)


func _on_player_detector_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	if (body as CharacterBody3D).get("is_possessed"):
		$doorControl.visible=false
		body.call("disable_depossessing",false)
