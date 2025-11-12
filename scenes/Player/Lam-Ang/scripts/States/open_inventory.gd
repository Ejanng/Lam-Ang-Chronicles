extends State
class_name PlayerInventory

@export var inventory: Inventory

@onready var inventory_gui = $"../../InventoryGui"

func Enter():
	if inventory_gui.isOpen:
		inventory_gui.close()
	else:
		inventory_gui.open()
