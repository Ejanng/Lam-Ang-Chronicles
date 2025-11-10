extends State

class_name PlayerAttack

@export var animator: AnimationPlayer
@export var hitbox_area: HitboxComponent
@export var attack_damage: float
@export var knockback_force: float
@export var stun_time: float

func Enter():
	# add attack audio here
	animator.play("Attack")
	await animator.animation_finished
	state_transit.emit(self, "PlayerIdle")
	
func perform_attack():
	print("Overlapping areas:", hitbox_area.get_overlapping_areas())
	for area in hitbox_area.get_overlapping_areas():
		print(area)
		if area is HitboxComponent:
			var attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force
			attack.stun_time = stun_time
			area.damage(attack)
			print(attack.attack_damage)
