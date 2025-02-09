extends Node2D


var bopTimer = 0.0





func DJCharacterSwitch(CH: String):
	match CH:
		"freeplayBF":
			if $"bf/bottom".symbol != get_parent().get_meta("currDJAnim"): $"bf/bottom".symbol = get_parent().get_meta("currDJAnim")
			if $"bf/top".symbol != $"bf/bottom".symbol: $"bf/top".symbol = $"bf/bottom".symbol
			if $"bf/top".frame != $"bf/bottom".frame: $"bf/top".frame = $"bf/bottom".frame
			if get_parent().get_meta("currDJAnim") == "Boyfriend DJ":
				if bopTimer > (60.0 / 100.0):
					print("set")
					$"bf/bottom".frame = 0
					$TurnTable/LightsBehind.frame = 0
					bopTimer = 0.0
		"freeplayPico":
			pass
		
	




func _process(delta: float) -> void:
	DJCharacterSwitch(name)
	bopTimer += delta
	$TurnTable/lightsGlow.frame = $TurnTable/LightsBehind.frame
