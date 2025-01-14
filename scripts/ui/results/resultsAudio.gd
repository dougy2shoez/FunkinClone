extends AudioStreamPlayer



func _ready() -> void:
	stream = load("res://assets/music/resultsScreen/pico/resultsNORMAL-pico.ogg")
	play()




func _process(delta: float) -> void:
	pass
