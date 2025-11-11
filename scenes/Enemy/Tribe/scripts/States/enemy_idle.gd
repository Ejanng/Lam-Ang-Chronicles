extends State
class_name EnemyIdle

@export var animator: AnimationPlayer

func Enter():
	animator.play("EnemyIdle")
	
