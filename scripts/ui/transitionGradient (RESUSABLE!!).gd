extends Sprite2D


func _ready() -> void:
	pass 
var fullScreenCover
var calledForTransition = false
func _process(delta: float) -> void:
	if calledForTransition == true:
		if position.y < 2000: 
			position.y += delta * 1100
			if position.y > 222:
				fullScreenCover = true
		else: calledForTransition = false
	else: 
		fullScreenCover = false
		position.y = -2600
