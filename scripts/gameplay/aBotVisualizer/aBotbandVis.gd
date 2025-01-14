extends Node2D

func _ready() -> void:
	visID = get_parent().visID
	$visAnimate.play(str(visID))

var visID
var setID = false
var frame
func _process(delta: float) -> void:
	if setID == false:
		visID = get_parent().visID
		setID = true
	frame = get_parent().get_node("VisMain").data[int(str($visAnimate.get_animation()))] / 145
	$visAnimate.set_frame(frame)
	pass
