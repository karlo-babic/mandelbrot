extends Node2D

var Mat
var zoom = 0.05
var pos_x = -8
var pos_y = -8
var panning_step = 0.1 / zoom
var dragging_prev_pos
var mode = 0
var mode_z = 0


func _ready():
	Mat = self.get_material()
	Mat.set_shader_parameter("mode", mode)
	Mat.set_shader_parameter("mode_z", mode_z)


func _unhandled_input(event):
	if Input.is_action_pressed("zoom_in"):
		zoom *= 1.1
		panning_step = 0.1 / zoom
		pos_x += panning_step/2.
		pos_y += panning_step/2.
		pos_x += (event.position.x - $"..".window_size.x/2) / ($"..".window_size.x/2) * panning_step/2
		pos_y += (event.position.y - $"..".window_size.y/2) / ($"..".window_size.y/2) * panning_step/2
	elif Input.is_action_pressed("zoom_out"):
		zoom /= 1.1
		panning_step = 0.1 / zoom
		pos_x -= panning_step/2.
		pos_y -= panning_step/2.
		pos_x -= (event.position.x - $"..".window_size.x/2) / ($"..".window_size.x/2) * panning_step/2
		pos_y -= (event.position.y - $"..".window_size.y/2) / ($"..".window_size.y/2) * panning_step/2
	elif Input.is_action_just_pressed("click"):
		dragging_prev_pos = event.position
	elif Input.is_action_pressed("click"):
		var zoom_normalization = 0.0006/zoom
		var panning = dragging_prev_pos - event.position
		pos_x += panning.x * zoom_normalization
		pos_y += panning.y * zoom_normalization
		dragging_prev_pos = event.position
	elif Input.is_action_just_pressed("enter"):
		zoom = 0.05
		pos_x = -8
		pos_y = -8
	elif Input.is_action_just_pressed("mode"):
		if mode == 0:
			mode = 1
		elif mode == 1:
			mode = 0
		Mat.set_shader_parameter("mode", mode)
	elif Input.is_action_just_pressed("mode_z"):
		if mode_z == 2:
			mode_z = 0
		else:
			mode_z += 1
		Mat.set_shader_parameter("mode_z", mode_z)


func _process(delta):
	Mat.set_shader_parameter("zoom", zoom)
	Mat.set_shader_parameter("pos_x", pos_x)
	Mat.set_shader_parameter("pos_y", pos_y)
