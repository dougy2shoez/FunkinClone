extends AudioStreamPlayer


func _ready() -> void:
	pass


var readySong = false
var playSong = false
func _process(delta: float) -> void:
	pitch_scale = get_parent().get_node("Inst").pitch_scale
	if readySong == false:
		if MasterVars.songType == "":
			stream = load("res://assets/songs/" + str(get_parent().songName) + "/" + "VoicesP2.ogg")
		else: 
			stream = load("res://assets/songs/" + str(get_parent().songName) + "/" + "VoicesP2-" + str(MasterVars.songType) + ".ogg")
		volume_db = -5
		readySong = true
	if get_parent().timerCountDown > 0:
		if playSong == false:
			play()
			playSong = true
	if get_parent().playingVocalsP2: volume_db = -5
	else: volume_db = -999
