extends AnimatableBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detector_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if (body as CharacterBody3D).get("is_possessed"):
		$doorControl.visible=true


func _on_player_detector_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	if (body as CharacterBody3D).get("is_possessed"):
		$doorControl.visible=false
