@tool
extends Node3D

@export var length = 20
@export var frequency = 1.0
@export var start_angle = 1.0
@export var base_size = 1
@export var multiplier = 5.0

@export var head_scene: PackedScene
@export var body_scene: PackedScene


func _process(delta):
	var angle_step = 2 * PI * frequency / length  
	var current_angle = start_angle

	# Compute the size factor for the first box
	var first_sine_value = sin(current_angle)
	var first_size_factor = remap(first_sine_value, -1, 1, base_size, base_size * multiplier)
	var first_box_size = Vector3(first_size_factor, first_size_factor, first_size_factor)

	# Changing position to fix the middle of the box to be at 0, 0, 0
	var position = global_transform.origin - global_transform.basis.z * (first_box_size.x / 2) - global_transform.basis.x * (first_box_size.x / 2) - global_transform.basis.y * (first_box_size.x / 2)

	# Draw boxes
	for i in range(length):
		var sine_value = sin(current_angle)
		var size_factor = remap(sine_value, -1, 1, base_size, base_size * multiplier)
		var box_size = Vector3(size_factor, size_factor, size_factor)

		DebugDraw3D.draw_box(position, Quaternion.IDENTITY, box_size, Color.CYAN)

		# Update position for the next box to start where the previous box ends
		position += global_transform.basis.z * box_size.x

		# Angle changes for each box
		current_angle += angle_step

		
func _ready():
	if not Engine.is_editor_hint():
		create_creature()

func create_creature():
	var angle_step = 2 * PI * frequency / length  
	var position = global_transform.origin  
	var current_angle = start_angle

	# Instantiate and configure the head segment
	var head = head_scene.instantiate()
	var head_box = head.get_node("CSGBox3D") as CSGBox3D
	if head_box:
		var size_factor = remap(sin(current_angle), -1, 1, base_size, base_size * multiplier)
		head_box.size = Vector3(size_factor, size_factor, size_factor)
		head.global_transform.origin = position
		add_child(head)

		# Update the position for the body segments
		position += head.global_transform.basis.z * size_factor

	current_angle += angle_step

	# Instantiate and configure the body segments
	for i in range(1, length):
		var body = body_scene.instantiate() as CSGBox3D
		if body:
			var sine_value = sin(current_angle)
			var size_factor = remap(sine_value, -1, 1, base_size, base_size * multiplier)
			body.size = Vector3(size_factor, size_factor, size_factor)
			body.global_transform.origin = position
			add_child(body)

			# Update position for the next segment
			position += body.global_transform.basis.z * size_factor
		current_angle += angle_step

func remap(value, from_min, from_max, to_min, to_max):
	return (value - from_min) / (from_max - from_min) * (to_max - to_min) + to_min
	
#func _input(event):
	#if event is InputEventKey and event.pressed and event.keycode == KEY_P:
		#toggle_pause()

	



