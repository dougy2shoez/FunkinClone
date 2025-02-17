extends Node2D
func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	if get_parent().get_parent().isPausable:
		if Input.is_action_just_pressed("confirm"):
			visible = not visible 
			get_tree().paused = not get_tree().paused
	else: visible = false
	if get_tree().paused:
		modulate.a += (1-modulate.a) / (0.075 / delta)
	else: 
		modulate.a = 0
