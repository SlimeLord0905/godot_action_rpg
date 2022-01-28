extends AnimatedSprite



func _ready():
	self.connect("animation_finished",self,"_on__animation_finished")
	frame = 0 
	play("animate")


func _on__animation_finished():
	queue_free()
