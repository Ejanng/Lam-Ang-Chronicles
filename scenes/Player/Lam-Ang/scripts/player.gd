extends CharacterBody2D

class_name LamAng

@onready var sm = $State as StateMachine
#const DEATH_SCREEN = preload("")

func die():
	#super()
	sm.force_change_state("Die")
	#var death_scene = DEATH_SCREEN.instantiate()
	#add_child(death_scene)
	
	pass
	
