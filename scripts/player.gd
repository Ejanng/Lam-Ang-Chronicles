extends CharacterBody2D
class_name Player

@export var sprite: AnimatedSprite2D
@export var health: HealthComponent
@export var hitbox_area: HitboxComponent
@export var attack_damage: float
@export var knockback_force: float
@export var stun_time: float

var invincible: bool = false
var is_dead: bool = false

func _ready():
	init_character()

func init_character():
	health.healthbar.max_value = health.MAX_HEALTH
	health.healthbar.value = health.health

func after_damage_iframes():
	invincible = true
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.DARK_RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	tween.tween_property(self, "modulate", Color.RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	await tween.finished
	invincible = false

func perform_attack():
	for area in hitbox_area.get_overlapping_areas():
		if area is HitboxComponent:
			var attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force
			attack.stun_time = stun_time
			area.damage(attack)

func die():
	if is_dead:
		return
		
	is_dead = true
	await get_tree().create_timer(1.0).timeout
	if is_instance_valid(self) and !is_in_group("Player"):
		queue_free()
