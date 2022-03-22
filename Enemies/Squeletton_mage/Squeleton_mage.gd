extends KinematicBody2D

const EnemiedeathEffect = preload("res://Effects/EnemieDeathEffect.tscn")
export (PackedScene) var boule_de_feu: PackedScene= preload("res://hitbox_and_hurtbox/boule de feu_enemie.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 40
export var FRICTION = 200 

enum{
	IDLE,
	WANDER,
	CHASE,
	ATTAQUE,
	DEAD
}
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var stats =$stats
onready var detection_zone = $player_detection
onready var detection_zone_attaque = $attaque_detection
onready var hurtbox = $hurtbox
onready var animation_player = $Sprite/AnimationPlayer
onready var animation_tree = $Sprite/AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var BTimer = $BTimer



var state = IDLE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta )
	knockback = move_and_slide(knockback)
	animation_tree.active = true
	
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta )
			animation_state.travel("Idle")
			seek_player()
		WANDER:
			pass
		ATTAQUE:
			if detection_zone.can_see_player():
				state = CHASE
			else:
				var player = detection_zone_attaque.player
				if player != null:
					if BTimer.is_stopped():
						velocity = Vector2.ZERO
						var direction = -(player.global_position - global_position).normalized()
						animation_tree.set("parameters/Idle/blend_position", direction)
						animation_tree.set("parameters/Attaque/blend_position", direction)
						animation_tree.set("parameters/mouvement/blend_position", direction)
						animation_state.travel("attaque")
						
						var boule = boule_de_feu.instance()
						get_tree().current_scene.add_child(boule)
						boule.global_position = self.global_position
						
						var Brotation = self.global_position.direction_to(player.global_position).angle() 
						boule.rotation = Brotation
						
						var boule2 = boule_de_feu.instance()
						get_tree().current_scene.add_child(boule2)
						boule2.global_position = self.global_position
						
						Brotation = (self.global_position.direction_to(player.global_position).angle()) + 1
						boule2.rotation = Brotation
						
						var boule3 = boule_de_feu.instance()
						get_tree().current_scene.add_child(boule3)
						boule3.global_position = self.global_position
						
						Brotation = (self.global_position.direction_to(player.global_position).angle()) - 1
						boule3.rotation = Brotation
						BTimer.start()
		CHASE:
			var player = detection_zone.player
			if player != null:
				var direction = -(player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta )
				animation_tree.set("parameters/Idle/blend_position", direction)
				animation_tree.set("parameters/Attaque/blend_position", direction)
				animation_tree.set("parameters/mouvement/blend_position", direction)
				animation_state.travel("mouvement")
			if player == null:
				state = IDLE
		DEAD:
		
			animation_state.travel("mort")
			velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)	
		
func seek_player():
		if detection_zone_attaque.can_see_player_attaque(): 
			state = ATTAQUE
		
func _on_hurtbox_area_entered(area):
	stats.health -= 1
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()

func _on_Node_no_health():
	$deathsound.play()
	state = DEAD
	var enemiedeatheffect = EnemiedeathEffect.instance()
	get_parent().add_child(enemiedeatheffect)
	enemiedeatheffect.position = global_position





