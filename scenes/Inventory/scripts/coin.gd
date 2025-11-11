extends Area2D

@export var itemResource = preload("res://scenes/Inventory/scenes/coin.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var inv = body.inventory		# remember to instantiate the inventory in the main
		if inv and itemResource:
			inv.insert(itemResource)
			queue_free()
