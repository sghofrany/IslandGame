extends Node3D
@onready var world_environment = $WorldEnvironment
@onready var directional_light_3d = $DirectionalLight3D
@onready var detail_tree_3 = $detail_tree3

@onready var Tile = preload("res://tile.tscn")
@onready var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	print(directional_light_3d.rotation)
	print(world_environment.environment.background_energy_multiplier)
#	generate_island(5, 5)

func _physics_process(delta):
	pass
#	var prev_x = directional_light_3d.rotation.x
#	var next_x = prev_x - 1
#
#	var x = lerp(prev_x, next_x , 0.25 * delta)
#
#	var x_deg = rad_to_deg(x)
#
#	directional_light_3d.rotation.x = x
#
#	print(x_deg, world_environment.environment.background_energy_multiplier)
#
#	if abs(x_deg) > 190:
#		var em_prev = world_environment.environment.background_energy_multiplier
#		var em = lerp(em_prev, 0.3, 1 * delta)
#
##		world_environment.environment.background_energy_multiplier = em
#
#	if abs(x_deg) > 330:
#		directional_light_3d.rotation.x = 0.0
#		var em_prev = world_environment.environment.background_energy_multiplier
#		var em = lerp(em_prev, 1.0, 3 * delta)
#		world_environment.environment.background_energy_multiplier = em
	
func generate_island(width, length):
	for i in range(width):
		for j in range(length):
			var spawn_position = Vector3(i, 0, j)
			var cube_instance = Tile.instantiate()
			add_child(cube_instance)			
			cube_instance.set_global_position(spawn_position)
