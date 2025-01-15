extends Node2D


func _ready() -> void:
	name = get_parent().stnName

func _process(delta: float) -> void:
	name = get_parent().stnName
