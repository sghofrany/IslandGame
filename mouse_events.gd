extends Node3D

@onready var main_scene = $"../.."

@onready var cam = $"."
@onready var Cube = preload("res://tile.tscn")
@onready var actual = $"../../Control/Panel/Actual"
@onready var floor = $"../../Control/Panel/Floor"
@onready var camera_pivot = $".."

var RAY_LENGTH = 20000

@onready var new_pivot_position = Vector3(camera_pivot.global_position.x, 0.5, camera_pivot.global_position.z)

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mouse_pos = get_mouse_world_pos()
	actual.set_text("(" + str(mouse_pos.x) + ", " + str(mouse_pos.z) + ")")
	
	var current_pivot_position = Vector3(camera_pivot.global_position.x, 0.5, camera_pivot.global_position.z)
	if snapped(current_pivot_position, Vector3(0.001, 0.5, 0.001)) != snapped(new_pivot_position, Vector3(0.001, 0.5, 0.001)):
		var updated_pivot_position = lerp(current_pivot_position, new_pivot_position, 1.5 * delta)
		camera_pivot.set_global_position(updated_pivot_position)
		
		print(snapped(current_pivot_position, Vector3(0.001, 0.5, 0.001)), snapped(new_pivot_position, Vector3(0.001, 0.5, 0.001)))
	else:
		print("Equal")


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var mouse_position = get_mouse_world_pos()	
			var spawn_position = Vector3(round(mouse_position.x), 0, round(mouse_position.z))
			floor.set_text("(" + str(spawn_position.x) + ", " + str(spawn_position.z) + ")")
			var cube_instance = Cube.instantiate()
			main_scene.add_child(cube_instance)			
			cube_instance.set_global_position(spawn_position)
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var mouse_position = get_mouse_world_pos()	
			new_pivot_position = Vector3(mouse_position.x, 0.5, mouse_position.z)
				
#			camera_pivot.global_transform.origin.linear_interpolate(pivot_position, )
#			camera_pivot.set_global_position(pivot_position)
			

func get_mouse_world_pos():
	var mouse_pos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mouse_pos)
	var normal = cam.project_ray_normal(mouse_pos)
	var distance = -origin.y / normal.y
	return origin + normal * distance
