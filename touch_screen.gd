extends Panel

#float
@export var sensitivity_x: float = 0.5
@export var sensitivity_y: float = 0.5 

#Node
@export var Object_rotating_on_the_x_axis: Node3D
@export var Object_rotating_on_the_y_axis : Node3D

#bool
@export var Touch_control_mode: bool = true 

var touch_positions = {}  
var touch_started_in_panel = {}  

func _input(event):
	if not Touch_control_mode:
		touch_positions.clear()
		touch_started_in_panel.clear()
		return


	if event is InputEventScreenTouch and event.pressed:
		var panel_rect = get_global_rect()
		if panel_rect.has_point(event.position):
			touch_positions[event.index] = event.position
			touch_started_in_panel[event.index] = true
		else:
			touch_started_in_panel[event.index] = false


	elif event is InputEventScreenDrag:
		if event.index in touch_positions and touch_started_in_panel.get(event.index, false):
			var previous_position = touch_positions[event.index]
			var delta = event.position - previous_position
			touch_positions[event.index] = event.position  
			
			_rotate_3D(delta)


	elif event is InputEventScreenTouch and not event.pressed:
		touch_positions.erase(event.index)
		touch_started_in_panel.erase(event.index)


func _rotate_3D(delta: Vector2):
	Object_rotating_on_the_x_axis.rotation_degrees.y -= delta.x * sensitivity_x
	Object_rotating_on_the_y_axis.rotation_degrees.x = clamp(
		Object_rotating_on_the_y_axis.rotation_degrees.x - delta.y * sensitivity_y, -80, 80)
