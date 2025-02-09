extends Node2D

@onready var hpPos = get_parent().hpPos
func _ready() -> void:
	if get_parent().isEnemy == false:
		name = "playerIcon"
		scale.x = 1
	else: name = "enemyIcon"
	$animate.play(str(get_parent().iconAnimate))
func _process(delta: float) -> void:
	hpPos = get_parent().hpPos
	if name == "playerIcon":
		position.x += (70 - position.x) / (0.115 / delta)
		if hpPos < 0.25: $animate.set_frame(1)
		else: $animate.set_frame(0)
	else:
		if hpPos > 1.75: $animate.set_frame(1)
		else: $animate.set_frame(0)
		position.x += (-20 - position.x) / (0.115 / delta)
