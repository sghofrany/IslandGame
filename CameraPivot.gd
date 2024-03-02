extends Node3D

@onready var camera_3d = $Camera3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation_degrees.y += 0.1
	
