extends Sprite2D
@onready var startModulate = false
func startModulateColor():
	startModulate = true
func _process(delta: float) -> void:
	if startModulate:
		modulate += (Color("ffd863") - modulate) / (0.25 / delta) 
