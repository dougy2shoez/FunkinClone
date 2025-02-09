extends AnimatedSprite2D

func _ready() -> void:
	pass 
	
var playTimer = 0
func _process(delta: float) -> void:
	playTimer += delta
	if name == "popInText":
		if playTimer > 0.8:
				play("default")
	elif name == "popInScore":
		if playTimer > 1.2:
				play("default")
	
	
	else:
		if playTimer > 0.2:
			play("default")
