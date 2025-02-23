extends Node2D
func _ready() -> void:
	$breakfast.volume_db = -80
	visible = false
var pausedOption: int = 0
var textPos: Vector2 = Vector2(0,0)	
func _process(delta: float) -> void:
	if not get_tree().paused: pausedOption = 0
	$text.position += (textPos - $text.position) / (0.15 / delta) 
	if get_tree().paused:
		if pausedOption > 2: pausedOption = 2
		if pausedOption < 0: pausedOption = 0
		$breakfast.volume_db += (-10-$breakfast.volume_db) / (0.5 / delta)
		modulate.a += (1-modulate.a) / (0.075 / delta)
	else: 
		$breakfast.volume_db = -80
		modulate.a = 0
	if get_parent().get_parent().isPausable:
		textPos = Vector2(-37*pausedOption, -136*pausedOption)
		
		if Input.is_action_just_pressed("ui_up"): pausedOption -= 1
		if Input.is_action_just_pressed("ui_down"): pausedOption += 1
		if Input.is_action_just_pressed("confirm"):
			textPos = Vector2(-444.5, -999)
			match pausedOption:
				0:
					textPos
					$breakfast.volume_db = -80
					visible = not visible 
					get_tree().paused = not get_tree().paused
				1:
					get_tree().paused = false
					get_tree().reload_current_scene()
					queue_free()
				2: 
					get_tree().paused = false
					get_tree().change_scene_to_file("res://scenes/freeplayMain.tscn")
					queue_free()
			pausedOption = 0
	else: 
		visible = false
func _notification(notif):
	if notif == NOTIFICATION_APPLICATION_FOCUS_OUT:
		textPos = Vector2(-444.5, -999)
		if get_parent().get_parent().isPausable:
			get_tree().paused = true
			if not get_tree().paused: $breakfast.volume_db = -80
			visible = true
