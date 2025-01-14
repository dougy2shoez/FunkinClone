extends AnimatedSprite2D


func _ready() -> void:
	play("default")




var confirmed = false
var lastBeat = 0
func _process(delta: float) -> void:
	if name == "Bumpin":
		if get_parent().currBeat != lastBeat:
			set_frame(0)
			lastBeat = get_parent().currBeat
	elif name == "pressEnter":
		if confirmed == true: play("confirm")
		else: play("default")
		if Input.is_action_just_pressed("confirm"):
			if get_parent().introText == true:
				get_parent().introText = false
				
			else: 
				confirmed = true
			
		if Input.is_action_just_pressed("confirm"):
			if get_parent().introText == false:
				get_parent().get_node("Gradient").calledForTransition = true
			
		
	
	visible = not get_parent().introText 
	if get_parent().get_node("Gradient").fullScreenCover == true:
				queue_free()
		
	
