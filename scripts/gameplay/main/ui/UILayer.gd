extends CanvasLayer
@onready var strumScene = preload("res://scenes/Strum.tscn")
@onready var strumID
@onready var enemyStrum = 0
@onready var lastBeat = 0
@onready var checkMaterial = false
var camBop: Array = [0.0, 1]
var bpRateCamCount = 0
func _ready() -> void:
	for i in 4:
		strumID = i - 1
		strumScene.instantiate().name = ("Strum" + str(i)) 
		add_child(strumScene.instantiate())
	enemyStrum = 1
	for i in 4:
		strumID = i - 1
		strumScene.instantiate().name = ("Strum" + str(i + 4)) 
		add_child(strumScene.instantiate())
	enemyStrum = 0
func _process(delta: float) -> void:
	if not checkMaterial:
		$HealthBar/iconz.material = get_parent().material
	if $Conductor.currBeat != lastBeat:
		bpRateCamCount += 1
		if bpRateCamCount >= camBop[1]:
			scale.x += camBop[0] / 100
			scale.y += camBop[0] / 100
			lastBeat = $Conductor.currBeat
	offset.x = (scale.x- 1)* -500
	offset.y = (scale.y- 1)* -250
	scale.x += (1-scale.x) / (.25/delta)
	scale.y += (1-scale.y) / (.25/delta)
