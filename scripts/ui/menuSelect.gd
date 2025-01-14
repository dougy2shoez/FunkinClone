extends Node2D


func _ready() -> void:
	var id = get_parent().id
	$animate.play(str(id) + "_" + "hold")
	position.y = (160*id) + 300
	position.x = 640
	name = str(id) + "_selectText"

	

@onready var id = get_parent().id
func _process(delta: float) -> void:
	$animate.play(str(id) + "_" + "hold")
	position.y = (160*id) + 300
	position.x = 640
