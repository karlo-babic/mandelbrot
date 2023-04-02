extends Node2D

var window_size
var window_size_larger


func _unhandled_input(event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED or DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _process(delta):
	### set texture scale and position
	if window_size != DisplayServer.window_get_size():
		window_size = DisplayServer.window_get_size()
		window_size_larger = max(window_size.x, window_size.y)/128.0
		$mandelbrot.set_scale(Vector2(window_size_larger, window_size_larger))
		$mandelbrot.set_position(window_size/2.)
