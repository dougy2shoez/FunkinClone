extends Node2D
@onready var hpPos = 1

# func _ready() -> void:


func _process(delta: float) -> void:
	hpPos = get_parent().get_node("Conductor").HP[0]
	$ColorBase/GreenStretch.scale.x += (((0 - hpPos * 0.94) - $ColorBase/GreenStretch.scale.x) / (.1 / delta))
