extends Area2D

var knockback_vector = Vector2.ZERO

export var damage = 1 

export (int) var speed: int = 100

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction * delta
	
func destroy():
	queue_free()

func _on_boule_de_feu_body_entered(body):
	destroy()


func _on_boule_de_feu_area_entered(area):
	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
