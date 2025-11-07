extends Node2D

var currentWave: int = 1
@export var enemy_melee_scene: PackedScene
@export var enemy_projectile_scene: PackedScene

var startingNodes: int
var currentNodes: int
var waveSpawnEnded: bool = false

var melee_spawn_points: Array[Marker2D] = []
var projectile_spawn_points: Array[Marker2D] = []

func _ready():
	# Collect all spawn markers automatically
	for child in get_children():
		if child.name.begins_with("MeleeTribeSpawnPoint"):
			melee_spawn_points.append(child)
		elif child.name.begins_with("ProjectileTribeSpawnPoint"):
			projectile_spawn_points.append(child)

	startingNodes = get_child_count()
	currentNodes = startingNodes
	Global.currentWave = currentWave
	position_to_next_wave()


func position_to_next_wave():
	if currentNodes == startingNodes:
		if currentWave != 0:
			Global.moveingToNextWave = true
		waveSpawnEnded = false

		currentWave += 1
		Global.currentWave = currentWave

		prepare_spawn("melee", 6.0, 6.0)
		prepare_spawn("projectile", 6.0, 6.0)
		print("Wave started:", currentWave)


func prepare_spawn(type: String, multiplier: float, mobSpawns: float):
	var mobAmount = float(currentWave) * multiplier
	var mobWaitTime = 2.0
	print("mob amount:", mobAmount)
	var mobSpawnRounds = int(mobAmount / mobSpawns)
	spawn_type(type, mobSpawnRounds, mobWaitTime)


func spawn_type(type: String, mobSpawnRounds: int, mobWaitTime: float) -> void:
	var spawn_points: Array[Marker2D] = []
	var mob_scene: PackedScene = null

	if type == "melee":
		spawn_points = melee_spawn_points
		mob_scene = enemy_melee_scene
	elif type == "projectile":
		spawn_points = projectile_spawn_points
		mob_scene = enemy_projectile_scene
	else:
		return

	if spawn_points.is_empty():
		print("⚠️ No spawn points found for", type)
		return

	for round in range(mobSpawnRounds):
		for i in range(6):  # how many enemies per round
			var spawn_point = spawn_points.pick_random()  # ✅ pick random marker
			var mob = mob_scene.instantiate()
			mob.global_position = spawn_point.global_position
			add_child(mob)
		await get_tree().create_timer(mobWaitTime).timeout

	waveSpawnEnded = true


func _process(delta):
	currentNodes = get_child_count()
	if waveSpawnEnded:
		position_to_next_wave()
