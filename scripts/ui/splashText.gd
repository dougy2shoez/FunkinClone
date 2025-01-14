extends Node2D


func _ready() -> void:
	$text.text = get_parent().textSplashSpawn # set text display wwwwwwwwwwwwwwwwwwwwww

@onready var beatsWait = get_parent().beatsWait
@onready var BPM = float(get_parent().BPM)
@onready var beatTimer = 0.0
func _process(delta: float) -> void:
	beatTimer += delta
	if beatTimer > ((60/BPM) * beatsWait): # uhh this is the formula i tink
		get_parent().allowPass = false
		queue_free()
