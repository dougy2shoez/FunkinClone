extends RichTextLabel

func _ready() -> void:
	pass 
var isFullscreenToggled = false
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fullScreen"):
		if isFullscreenToggled == false: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			isFullscreenToggled = true
		else: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			isFullscreenToggled = false
	if Input.is_action_just_pressed("reloadScene"):
		get_tree().reload_current_scene()
	text = (" FPS: " + str(round(1/delta)))
	pass
