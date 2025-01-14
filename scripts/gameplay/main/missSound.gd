extends AudioStreamPlayer
@onready var missSound1 = preload("res://assets/sounds/gameplay/missnote1.ogg")
@onready var missSound2 = preload("res://assets/sounds/gameplay/missnote2.ogg")
@onready var missSound3 = preload("res://assets/sounds/gameplay/missnote3.ogg")
var randomInt = 1
func playMissSound():
	volume_db = -5
	randomInt = (randi() % 3 + 1)
	stream = load(("res://assets/sounds/gameplay/missnote") + str(randomInt) + ".ogg")
	play()
