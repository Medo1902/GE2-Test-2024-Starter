@tool
extends Node3D

@export var length = 20
@export var frequency = 1
@export var start_angle = 1
@export var base_size = 1
@export var multiplier = 1

func _process(delta):
	var box_size = Vector3(base_size, base_size, base_size)  # Size of each box
	for i in range(length):
		var position = global_transform.origin + -global_transform.basis.x * base_size * i 
		DebugDraw3D.draw_box(position, Quaternion.IDENTITY, box_size, Color.CYAN)


func _ready():
	if not Engine.is_editor_hint():		
		pass




