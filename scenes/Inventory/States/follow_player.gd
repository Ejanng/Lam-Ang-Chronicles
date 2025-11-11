extends State
class_name FollowPlayer

@export var speed: float = 30
@export var body: CharacterBody2D

func Update(delta):
	var player = get_tree().get_first_node_in_group("Player") as CharacterBody2D
	var follow_direction = player.position - body.position as Vector2
	
	body.velocity = follow_direction.normalized() * speed
	body.move_and_slide()
