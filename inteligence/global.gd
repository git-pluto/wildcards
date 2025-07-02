extends Node

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("f11"):
		if DisplayServer.window_get_mode() != 4:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
