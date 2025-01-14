extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
