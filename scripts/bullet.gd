extends CharacterBody3D


var player_position_set = false
const SPEED = 115.0

func set_player_position(pos : Vector3):
	look_at(pos)
	player_position_set = true

func _physics_process(delta):
	if player_position_set :	
		var col = move_and_collide(-basis.z * delta * SPEED)
		if col :
			
			col.get_collider().call("got_attacked")
			queue_free()


func _on_destruction_timeout():
	queue_free()
	pass # Replace with function body.
