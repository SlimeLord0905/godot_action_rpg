extends Node2D

const grassEffect = preload("res://Effects/grasseffect.tscn")
export (PackedScene) var hearth: PackedScene= preload("res://Player/hearth/hearth.tscn")


func create_grass_effect():
		var grasseffect = grassEffect.instance()
		var world = get_tree().current_scene
		get_parent().add_child(grasseffect)
		grasseffect.global_position = global_position
		queue_free()




func _on_hurtbox_area_entered(area):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_number = rng.randf_range(-10.0, 1.0)
	if random_number > 0 and global.gamemode == 2:
		var hearth_health = hearth.instance()
		get_tree().current_scene.add_child(hearth_health)
		hearth_health.global_position = self.global_position
		hearth_health.global_position.x -= 10
		hearth_health.global_position.y -= 10
		
	create_grass_effect()
	queue_free()
