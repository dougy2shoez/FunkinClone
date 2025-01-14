extends AnimatedSprite2D



func _ready() -> void:
	play("default")
	if name == "rank":
		play("P_UPPER")
	
func _process(delta: float) -> void:
	pass
