extends CanvasLayer
@onready var strumScene = preload("res://scenes/Strum.tscn")
@onready var strumID
@onready var enemyStrum  = 0
@onready var checkMaterial = false
var camBop: Array = [1, 4]
func _ready() -> void:
	Conductor.connect("onBeatHit", onBeatHit)
	Conductor.connect("onMeasureHit", onMeasureHit)
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
	offset.x = (scale.x- 1)* -500
	offset.y = (scale.y- 1)* -250
	scale.x += (1-scale.x) / (.25/delta)
	scale.y += (1-scale.y) / (.25/delta)
func onBeatHit():
		if Conductor.currBeatTime >= camBop[1]:
			scale.x += camBop[0] / 100
			scale.y += camBop[0] / 100
			get_parent().get_node("gameCam").zoom.x += camBop[0] / 100
			get_parent().get_node("gameCam").zoom.y += camBop[0] / 100
func onMeasureHit():
	scale.x += 0.005
	scale.y += 0.005
	get_parent().get_node("gameCam").zoom.x += 0.005
	get_parent().get_node("gameCam").zoom.y += 0.005
