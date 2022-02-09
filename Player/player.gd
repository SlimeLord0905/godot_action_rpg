extends KinematicBody2D

export var MAX_SPEED = 80
export var ROLL_SPEED = 100
export var ACCELERATION = 500
export var FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var swordhitbox = $itboxpivot/sword_hitbox
onready var hurtbox = $hurtbox

func _ready():
	stats.connect("no_health",self,"queue_free")
	animation_tree.active = true
	swordhitbox.knockback_vector = roll_vector

func _physics_process(delta):
	
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input. get_action_strength("ui_right") - Input. get_action_strength("ui_left")
	input_vector.y = Input. get_action_strength("ui_down") - Input. get_action_strength("ui_up") 
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordhitbox.knockback_vector = input_vector
		animation_tree.set("parameters/idle/blend_position", input_vector)
		animation_tree.set("parameters/run/blend_position", input_vector)
		animation_tree.set("parameters/attack/blend_position", input_vector)
		animation_tree.set("parameters/roll/blend_position", input_vector)
		animation_state.travel("run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED , ACCELERATION * delta )
	else:
		animation_state.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()	
		
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	if Input.is_action_just_pressed("roll"):
		state = ROLL

func roll_state(delta):
	velocity = roll_vector*ROLL_SPEED
	animation_state.travel("roll")
	move()
	
func attack_state(delta):
	velocity = Vector2.ZERO
	animation_state.travel("attack")
	
func move():
	velocity = move_and_slide(velocity)

func roll_animation_finished():
	velocity = velocity/2
	state = MOVE

func attack_animation_finish():
	state = MOVE
	


func _on_hurtbox_area_entered(area):
	stats.health -= 1
	hurtbox.start_invincibility(0.5)
	hurtbox.create_hit_effect()