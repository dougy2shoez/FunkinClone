extends AudioStreamPlayer

func _ready() -> void:
	stream = preload("res://assets/music/freakyMenu.ogg")
	volume_db = -5
	play()
	pass
func _process(delta: float) -> void:
	pass
