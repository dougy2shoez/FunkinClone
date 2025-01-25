extends Node2D


var bopTimer = 0.0

func _process(delta: float) -> void:
	bopTimer += delta
	print(bopTimer)
	$TurnTable/lightsGlow.frame = $TurnTable/LightsBehind.frame
	$"bf body".frame = $"bf body/bf top".frame
	if bopTimer > (60.0 / 100.0):
		print("set")
		$"bf body/bf top".frame = 0
		$TurnTable/LightsBehind.frame = 0
		bopTimer = 0.0
		
