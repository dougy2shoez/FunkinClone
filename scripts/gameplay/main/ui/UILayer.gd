extends CanvasLayer
@onready var strumScene = preload("res://scenes/Strum.tscn")
@onready var strumID
@onready var enemyStrum = 0
@onready var zoomBop = 1
@onready var lastBeat = 0
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
	if $Conductor.currBeat != lastBeat:
		scale.x += 0.005
		scale.y += 0.005
		lastBeat = $Conductor.currBeat
	offset.x = (scale.x- 1)* -500
	offset.y = (scale.y- 1)* -250
	scale.x += (1-scale.x) / (.25/delta)
	scale.y += (1-scale.y) / (.25/delta)
