extends Area2D


var player = null 

func can_see_player():
	return player != null
func _on_player_detection_body_entered(body):
	player = body
func _on_player_detection_body_exited(body):
	player = null