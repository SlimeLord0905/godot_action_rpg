extends KinematicBody2D

const EnemiedeathEffect = preload("res://Effects/EnemieDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200 

enum{
	IDLE,
	WANDER,
	CHASE	
}
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var stats =$stats
onready var detection_zone = $player_detection
onready var sprite = $corrpse
onready var hurtbox = $hurtbox

var state = IDLE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta )
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta )
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = detection_zone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta )
			if player == null:
				state = IDLE
			sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)	
		
func seek_player():
	if detection_zone.can_see_player():
		state = CHASE
	
func _on_hurtbox_area_entered(area):
	stats.health -= 1
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()

func _on_stats_no_health():
	queue_free()
	var enemiedeatheffect = EnemiedeathEffect.instance()
	get_parent().add_child(enemiedeatheffect)
	enemiedeatheffect.position = global_position
