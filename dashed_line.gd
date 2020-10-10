tool
extends Node2D

export var point_a: = Vector2(-50.0, 0.0)
export var point_b: = Vector2(50.0, 0.0)
export var color: = Color(1, 1, 1, 1)
export var width: = 5.0
export var dash_length: = 5.0
export var cap_end: = false
export var antialiased: bool = false

func _process(_delta: float) -> void:
	update()

func _draw() -> void:
	draw_set_transform_matrix(transform.inverse())

	var length = (point_b - point_a).length()
	var normal = (point_b - point_a).normalized()
	var dash_step = normal * dash_length

	# If not long enough point_b dash, draw a line then return.
	if length < dash_length:
		draw_line(point_a, point_b, color, width, antialiased)
		return

	else:
		var draw_flag = true
		var segment_start = point_a
		var steps = length/dash_length
		for _start_length in range(0, steps + 1):
			var segment_end = segment_start + dash_step
			if draw_flag:
				draw_line(segment_start, segment_end, color, width, antialiased)

			segment_start = segment_end
			draw_flag = !draw_flag

		if cap_end:
			draw_line(segment_start, point_b, color, width, antialiased)

# The following code is more efficient but does not yet work as the
# draw_multiline function is unfinished.

#	draw_set_transform_matrix(transform.inverse())

#	var length = (point_b - point_a).length()
#	var normal = (point_b - point_a).normalized()
#	var dash_step = normal * dash_length

#	# If not long enough point_b dash, draw a line then return.
#	if length < dash_length:
#		draw_line(point_a, point_b, color, width, antialiased)
#		return

#	else:
#		var point = point_a
#		var steps = length/dash_length
#		var points: = []

#		for _start_length in range(0, steps + 1):
#			points.append(point)
#			point += dash_step

#		if cap_end:
#			points.append(point)
#			points.append(point_b)

#		draw_multiline(points, color, width, antialiased)
