extends Sprite2D
@onready var startModulate = false
func startModulateColor():
	startModulate = true
func _process(delta: float) -> void:
	if startModulate:
		if MasterVars.currCharacter != "bf":
			match MasterVars.currCharacter:
				"pico": modulate += (Color("8A91F2") - modulate) / (0.25 / delta) 
		else: modulate += (Color("ffd863") - modulate) / (0.25 / delta) 
