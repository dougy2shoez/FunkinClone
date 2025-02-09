extends AnimatedSprite2D



func _ready() -> void:
	if name == "rank":
		play("P_UPPER")
	else: play("default")
func _process(delta: float) -> void:
	pass
