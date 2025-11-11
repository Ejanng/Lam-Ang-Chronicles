extends State
class_name EnemyChase

@export var attack_range: float = 17
@export var move_speed: float = 50

@export var animator: AnimationPlayer
@onready var body = $"../.."

#  locations of collision when flip_h
@onready var anim = $"../../AnimatedSprite2D"
@onready var attack_hitbox = $"../../Sword"
@onready var hitbox = $"../../HitboxComponent"
@onready var collision = $"../../CollisionShape2D"

func Enter():
	animator.play("EnemyChase")
	
func Update(delta):
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	var chase_direction = player.position - body.position as Vector2
	
	body.velocity = chase_direction.normalized() * move_speed
	body.move_and_slide()
	
	if chase_direction.x > 0:		# right
		anim.flip_h = false
		hitbox.position = Vector2(0, 0)
		collision.position = Vector2(0, 11)
		attack_hitbox.position = Vector2(12, -3)
	elif chase_direction.x < 0:		# left
		anim.flip_h = true
		hitbox.position = Vector2(6, 0)
		collision.position = Vector2(6, 11)
		attack_hitbox.position = Vector2(-12, -3)
	
	if chase_direction.length() <= attack_range:
		state_transit.emit(self, "EnemyAttack") 
