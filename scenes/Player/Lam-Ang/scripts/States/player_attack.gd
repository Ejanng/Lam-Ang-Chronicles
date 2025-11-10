extends State

class_name PlayerAttack

@export var animator: AnimationPlayer

func Enter():
	# add attack audio here
	
	animator.play("Attack")
	await animator.animation_finished
	state_transit.emit(self, "Idle")
	


func _on_sword_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
