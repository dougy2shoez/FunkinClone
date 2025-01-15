extends Label

var animationPlayed = false
func _process(delta: float) -> void:
	if name == "num":
		if int(text) > 9:
			if not animationPlayed:
				get_parent().get_node("animate").play("comboPlaceholder/gotCombo")
				animationPlayed = true
			
		else: 
			animationPlayed = false
			get_parent().get_node("animate").play("comboPlaceholder/comboBreak")
