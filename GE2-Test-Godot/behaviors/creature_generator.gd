@tool
extends Node3D

@export var length = 20
@export var frequency = 1.0
@export var start_angle = 1.0
@export var base_size = 1
@export var multiplier = 5.0

func _process(delta):
	var angle_step = 2 * PI * frequency / length  # chaning angle, based on frequency and lenght
	var position = global_transform.origin  # Start position for the first box
	var current_angle = start_angle

	for i in range(length):
		var sine_value = sin(current_angle)
		var size_factor = remap(sine_value, -1, 1, base_size, base_size * multiplier)
		var box_size = Vector3(size_factor, size_factor, size_factor)

		DebugDraw3D.draw_box(position, Quaternion.IDENTITY, box_size, Color.CYAN)

		# updating the position of the box
		position += global_transform.basis.z * box_size.x

		# angle changes for each box
		current_angle += angle_step

func remap(value, from_min, from_max, to_min, to_max):
	return (value - from_min) / (from_max - from_min) * (to_max - to_min) + to_min

func _ready():
	if not Engine.is_editor_hint():		
		pass



