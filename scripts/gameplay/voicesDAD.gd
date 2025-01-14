extends AudioStreamPlayer


func _ready() -> void:
	pass


var readySong = false
var playSong = false
func _process(delta: float) -> void:
	pitch_scale = get_parent().get_node("Inst").pitch_scale
	if readySong == false:
		if MasterVars.songType == "":
			stream = load("res://assets/songs/" + str(get_parent().songName) + "/" + "VoicesP1.ogg")
		else: 
			stream = load("res://assets/songs/" + str(get_parent().songName) + "/" + "VoicesP1-" + str(MasterVars.songType) + ".ogg")
		volume_db = -5
		print("res://assets/songs/" + str(get_parent().songName) + "/" + "VoicesP1-" + str(MasterVars.songType) + ".ogg")
		readySong = true
		
	if get_parent().timerCountDown > 0:
		if playSong == false:
			play()
			playSong = true
