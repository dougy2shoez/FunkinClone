extends Node2D

var visPartScene = preload("res://scenes/abotVISPart.tscn")
var visID
var dataVis: Array
func _ready() -> void:
	for i in 7:
		visID = i
		add_child(visPartScene.instantiate())

func _process(delta: float) -> void:
	pass
