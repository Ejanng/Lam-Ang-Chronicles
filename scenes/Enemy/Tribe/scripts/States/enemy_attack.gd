extends State
class_name EnemyAttack

@onready var body = $"../.."
@onready var hitbox_area = $"../../HitboxComponent"
@export var animator: AnimationPlayer
@export var attack_damage: float
@export var knockback_force: float
@export var stun_time: float

func Enter():
	animator.play("EnemyAttack")
	await animator.animation_finished
	body.finished_attacking()
	print("im looping")
	
func perform_attack():
	for area in hitbox_area.get_overlapping_areas():
		print(area)
		if area is HitboxComponent:
			var attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force
			attack.stun_time = stun_time
			area.damage(attack)
			print(attack.attack_damage)
			
