extends CharacterBase

class_name Tribe

@onready var sm = $StateMachine as StateMachine
var player_in_range = false

@export var attack_node: Node
@export var chase_node: Node
@export var idle_only: bool = false

func finished_attacking():
	if player_in_range:
		sm.change_state(attack_node, "EnemyChase")
	else:
		sm.change_state(attack_node, "EnemyIdle")

func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true
		sm.change_state(chase_node, "EnemyIdle")
		if sm.current_state.name == "EnemyIdle":
			sm.force_change_state("EnemyChase")
			
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		sm.change_state(chase_node, "EnemyIdle")
		
func die():
	super()
	sm.force_change_state("EnemyDie")
