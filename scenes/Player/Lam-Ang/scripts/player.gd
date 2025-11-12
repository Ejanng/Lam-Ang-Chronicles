extends CharacterBase

class_name LamAng

@onready var sm = $State as StateMachine
#const DEATH_SCREEN = preload("")

@onready var inventory_gui = $InventoryGui

func _ready():
	inventory_gui.close()

func die():
	super()
	sm.force_change_state("Die")
	#var death_scene = DEATH_SCREEN.instantiate()
	#add_child(death_scene)
