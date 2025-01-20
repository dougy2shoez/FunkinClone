extends Control

func _ready() -> void:
	for x in 12:
		var seperator = Sprite2D.new()
		seperator.texture = preload("res://assets/images/Freeplay/sortedLetters/seperator.png")
		seperator.position = Vector2i(((x * 80) + 223), 44)
		seperator.scale = Vector2(0.67, 0.65)
		add_child(seperator)
