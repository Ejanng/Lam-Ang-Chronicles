extends Resource
class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert(item):
	var remaining = 1
	for slot in slots:
		if slot.item != null and slot.item.name == item.name:
			var space_left = item.maxAmountPerStack - slot.amount
			if space_left > 0:
				var to_add = min(space_left, remaining)
				slot.amount += to_add
				remaining -= to_add
				if remaining <= 0:
					updated.emit()
					return
					
	for slot in slots:
		if slot.item == null:
			slot.item = item
			slot.amount = min(item.maxAmountPerStack, remaining)
			remaining -= slot.amount
			if remaining <= 0:
				updated.emit()
				return
				
func remove_slot(inventory_slot: InventorySlot):
	var index = slots.find(inventory_slot)
	if index < 0: return
	remove_at_index(index)
	
func remove_at_index(index: int):
	slots[index] = InventorySlot.new()
	updated.emit()
	
func insert_slot(index: int, inventory_slot: InventorySlot):
	slots[index] = inventory_slot
	updated.emit()
	
func use_item_in_hand(index: int):
	if index < 0 or index >= slots.size(): return
	var slot = slots[index]
	if !slot.item: return
	var item = slot.item
	
	if item.isConsumable:
		# add function to register the effect

		if slot.amount > 1:
			slot.amount -= 1
			updated.emit()
			return
		remove_at_index(index)
	
