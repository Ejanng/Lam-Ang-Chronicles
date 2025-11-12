extends State
class_name PlayerIdle

@export var animator: AnimationPlayer

@onready var inventory_gui = $"../../InventoryGui"

func Enter():
	animator.play("Idle")
	
func Update(delta: float):
	if Input.is_action_just_pressed("Inventory"):
		state_transit.emit(self, "PlayerInventory")
			
	if Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized():
		state_transit.emit(self, "PlayerWalk")
		
	if Input.is_action_just_pressed("Attack"):
		state_transit.emit(self, "PlayerAttack")
