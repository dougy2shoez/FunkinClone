extends Node2D

@onready var digitalNumber = preload("res://scenes/ui/freeplay/digitalNum.tscn")
@onready var digitID = 0
@onready var scoreDisplay = "0000000"
func _ready() -> void:
	for n in 7:
		digitID = n
		add_child(digitalNumber.instantiate())



func _process(delta: float) -> void:
	pass
