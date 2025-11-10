extends Node2D

class_name HealthComponent

@export var MAX_HEALTH: float = 10.0
@export var healthbar: ProgressBar
@export var base: CharacterBase

var health: float

func _ready():
	health = MAX_HEALTH
	
func damage(attack: Attack):
	health -= attack.attack_damage
	healthbar.value = health
	
	if health <= 0:
		base.die()
		
