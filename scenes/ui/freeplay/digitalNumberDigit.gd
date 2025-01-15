extends Node2D


@onready var digit = get_parent().digitID
func _ready() -> void:
	position.x = digit * 45



@onready var scoreDisplay = get_parent().scoreDisplay
func _process(delta: float) -> void:
	print(scoreDisplay)
	scoreDisplay = get_parent().scoreDisplay
	$animate.play(str(str(scoreDisplay)[digit]))
	
	
	
