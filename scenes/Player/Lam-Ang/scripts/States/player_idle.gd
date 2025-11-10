extends State
class_name PlayerIdle

@export var animator: AnimationPlayer

func Enter():
	animator.play("Idle")
	pass
	
func Update(delta: float):
	if Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized():
		state_transit.emit(self, "PlayerWalk")
		
	if Input.is_action_just_pressed("Punch"):
		state_transit.emit(self, "PlayerAttack")
