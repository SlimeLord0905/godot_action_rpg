extends Node2D

const grassEffect = preload("res://Effects/grasseffect.tscn")

func create_grass_effect():
		var grasseffect = grassEffect.instance()
		var world = get_tree().current_scene
		get_parent().add_child(grasseffect)
		grasseffect.global_position = global_position
		queue_free()




func _on_hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
