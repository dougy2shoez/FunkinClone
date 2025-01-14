extends Node2D


func _ready() -> void:
	pass



func _process(delta: float) -> void:
	$BlackBarThing.position.x += (540 - $BlackBarThing.position.x) / (0.25 / delta) 
	$BlackBarThing.position.y += (336 - $BlackBarThing.position.y) / (0.1 / delta) 
	
	pass
