extends AudioStreamPlayer


func _ready() -> void:
	pass


var readySong = false
var playSong = false
func _process(delta: float) -> void:
	if readySong == false:
		if MasterVars.songType == "":
			stream = load("res://assets/songs/" + str(get_parent().songName) + "/" + "Inst.ogg")
		else: 
			stream = load("res://assets/songs/" + str(get_parent().songName) + "/" + "Inst-" + str(MasterVars.songType) + ".ogg")
		volume_db = -5
		readySong = true
		
	if get_parent().timerCountDown > 0:
		if playSong == false:
			play()
			playSong = true
