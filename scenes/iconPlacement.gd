extends Node2D
var id = 0
var row = 0
var sprite = Sprite2D.new()
func _ready() -> void:
	sprite.texture = preload("res://assets/images/Freeplay/icons/picopixel/confirm0001.png")
	sprite.scale = Vector2(2.5,2.5)
	sprite.texture_filter = 1
	sprite.position = Vector2(520,325)
	add_child(sprite)
	sprite = Sprite2D.new()
	sprite.texture = preload("res://assets/images/Freeplay/icons/bfpixel/confirm0001.png")
	sprite.scale = Vector2(2.5,2.5)
	sprite.texture_filter = 1
	sprite.position = Vector2(630,325)
	add_child(sprite)
