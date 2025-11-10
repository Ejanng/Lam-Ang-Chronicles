extends State

class_name PlayerWalk

@export var movespeed: int = 400
@export var dash_max: int = 500
var dashspeed: float = 100.0
var can_dash: bool = false
var dash_direction: Vector2 = Vector2.ZERO

var player: CharacterBody2D
@export var animator: AnimationPlayer

@onready var anim = $"../../AnimatedSprite2D"

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	print(player)
	
func Update(delta: float):
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	Move(input_dir)
	LessenDash(delta)
	
	if Input.is_action_just_pressed("Dash") and can_dash:
		start_dash(input_dir)
		
	if Input.is_action_just_pressed("Attack"):
		Transition("PlayerAttack")
	
func Move(input_dir: Vector2):
	if (dash_direction != Vector2.ZERO and dash_direction != input_dir):
		dash_direction = Vector2.ZERO
		dashspeed = 0
		
	player.velocity = input_dir * movespeed + dash_direction * dashspeed
	player.move_and_slide()
	
	var anim_name: String = ""
	
	if input_dir.x < 0:
		anim.flip_h = true
		anim_name = "Walk_Side"
	elif input_dir.x > 0:
		anim.flip_h = false
		anim_name = "Walk_Side"
	elif input_dir.y < 0:
		anim_name = "Walk_Up"
	elif input_dir.y > 0:
		anim_name = "Walk_Down"
	
	if animator.current_animation != anim_name:
		animator.play(anim_name)
		
	if (input_dir.length() <= 0):
		Transition("PlayerIdle")
	
		
func start_dash(input_dir: Vector2):
#	audio insert here
	dash_direction = input_dir.normalized()
	dashspeed = dash_max
	#animator.play("Dash")
	can_dash = false
	
func LessenDash(delta: float):
	var multiplier: float = 4.0
	var timemultiplier: float = 4.1
	
	dashspeed -= (dashspeed * multiplier * delta) + (delta * timemultiplier)
	dashspeed = clamp(dashspeed, 0, dash_max)
	
	if dashspeed <= 0:
		can_dash = true
		dash_direction = Vector2.ZERO
		
	# save for dash animation
	#if animator.current_animation == "Walk_Up" or animator.current_animation == "Walk_Down" or animator.current_animation == "Walk_Side":			
		#await animator.animation_finished
		#animator.play("Dash")
		
func Transition(newState: String):
	if dashspeed <= 0:
		state_transit.emit(self, newState)
	
