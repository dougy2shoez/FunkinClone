extends ColorRect


func _ready() -> void:
	pass



func _process(delta: float) -> void:
	if name == "theDarkness":
		if get_parent().get_node("Gradient").fullScreenCover == true:
			queue_free()
	
