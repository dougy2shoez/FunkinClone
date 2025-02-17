extends Node2D



func _ready() -> void:
	position = Vector2(2000, 640)
	pass


@onready var capsulePositions: Array = [[577,185],[628,300],[631,416],[585,532],[531,647]]
@onready var offscreenPositions: Array = [[541,-30],[519,781]]
@onready var selected = get_parent().currSelect
@onready var IDCapsule = get_parent().IDCapsule
@onready var songList = get_parent().songList
@onready var songID = songList[IDCapsule - 1] if IDCapsule != null else null
@onready var baseSongMetaData = get_parent().baseSongMetadata

var setFrames = false
var positionSet: Array = [0,0]


func setCapsulePositions(id: int):
	if (id - selected < 5):
		if (id - selected > -6):
			positionSet[0] = capsulePositions[id - selected][0]
			positionSet[1] = capsulePositions[id - selected][1]
		if (id - selected < 0):
			positionSet[0] = offscreenPositions[0][0]
			positionSet[1] = offscreenPositions[0][1]
	elif (id - selected > 4):
		positionSet[0] = offscreenPositions[1][0]
		positionSet[1] = offscreenPositions[1][1]


func loadJsonData(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedSong = JSON.parse_string(dataFile.get_as_text())
		if parsedSong is  Dictionary: return parsedSong
		else: print("invalid metadata!")
	else: print("doesnt exist in specified directory!")




var loadedSong = load("res://assets/songs/" + str(songID) + "/Inst.ogg" if MasterVars.songType == "" else "res://assets/songs/" + str(songID) + "/Inst-" + MasterVars.songType + ".ogg") if IDCapsule != null else load("res://assets/music/freeplayRandom.ogg")
func ifSelected(id):
	if not id == null:
		if (id - selected == 1):
			MasterVars.songName = songID
			$capsuleBase.play("Selected")
			$capsuleBase/TextContainer/songName.modulate = Color("FFFFFF")
			$capsuleBase/TextContainer/songName/notSelected.visible = false
			$capsuleBase/TextContainer/songName/songName.visible = true
			$capsuleBase/TextContainer/songName/songName2.visible = true
			if Input.is_action_pressed("confirm"):
				selectedSong()
			if setFrames == false:
				get_parent().get_node("musicFreeplay").stream = loadedSong
				get_parent().get_node("musicFreeplay").play()
				$capsuleBase/rank.set_frame(0)
				setFrames = true
		else: 
			$capsuleBase.play("notSelected")
			$capsuleBase/TextContainer/songName.modulate = Color("b1b1b1")
			setFrames = false
			$capsuleBase/TextContainer/songName/notSelected.visible = true
			$capsuleBase/TextContainer/songName/songName.visible = false
			$capsuleBase/TextContainer/songName/songName2.visible = false
			
	else: 
		if (0 - selected == 1):
			$capsuleBase/lcdScreenBacking.play("default")
			if Input.is_action_pressed("confirm"):
				pass
			if setFrames == false:
				$capsuleBase/rank.set_frame(0)
				setFrames = true
			
			$capsuleBase.play("Selected")
			$capsuleBase/TextContainer/songName.modulate = Color("FFFFFF")
			setFrames = false
			$capsuleBase/TextContainer/songName/songName.visible = true
			$capsuleBase/TextContainer/songName/notSelected.visible = false
			$capsuleBase/TextContainer/songName/songName2.visible = false
			
		else: 
			$capsuleBase.play("notSelected")
			$capsuleBase/TextContainer/songName.modulate = Color("b1b1b1")
			setFrames = false
			$capsuleBase/TextContainer/songName/notSelected.visible = false
			$capsuleBase/TextContainer/songName/songName.visible = false
			$capsuleBase/TextContainer/songName/songName2.visible = false







func selectedSong():
	if IDCapsule != null:
		MasterVars.BPMGLOBAL = metaDATACAPSULE["timeChanges"][0]["bpm"]
		get_tree().change_scene_to_file("res://scenes/playScene.tscn")
		get_parent().queue_free()
	else: 
		pass 



var metaDATACAPSULE

func setGlowVisble(truee: bool):
	$capsuleBase/TextContainer/songName/glowEffect.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect2.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect3.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect4.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect5.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect6.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect7.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect8.visible = truee

func setGlowStrength(stgth: int):
	$capsuleBase/TextContainer/songName/glowEffect.material.set_shader_parameter('glow_strength',stgth)
	$capsuleBase/TextContainer/songName/glowEffect2.material.set_shader_parameter('glow_strength',(stgth))
	$capsuleBase/TextContainer/songName/glowEffect3.material.set_shader_parameter('glow_strength',stgth)
	$capsuleBase/TextContainer/songName/glowEffect4.material.set_shader_parameter('glow_strength',(stgth))
	$capsuleBase/TextContainer/songName/glowEffect5.material.set_shader_parameter('glow_strength',(stgth)) 
	$capsuleBase/TextContainer/songName/glowEffect6.material.set_shader_parameter('glow_strength',(stgth)) 
	$capsuleBase/TextContainer/songName/glowEffect7.material.set_shader_parameter('glow_strength',(stgth/4))
	$capsuleBase/TextContainer/songName/glowEffect8.material.set_shader_parameter('glow_strength',(stgth/4))

func variationCheck(id: int):
	if baseSongMetaData["playData"].has("songVariations"):
		if not baseSongMetaData["playData"]["songVariations"].has(MasterVars.songType) and not MasterVars.songType == "":
			get_parent().erasedSongs.append({"songID": songID, "indexed": songList.find(songID)})
			get_parent().songList.remove_at(id - 1)
			queue_free()
	elif not MasterVars.songType == "": 
		get_parent().erasedSongs.append({"songID": songID, "indexed": songList.find(songID)})
		get_parent().songList.remove_at(id - 1)
		queue_free()
		queue_free()

func loadMetaData():
	if not loadedMetaData:
		if baseSongMetaData["playData"].has("songVariations"):
			if baseSongMetaData["playData"]["songVariations"].has(MasterVars.songType):
				metaDATACAPSULE = loadJsonData("res://assets/data/songs/" + str(songID) + "/" + str(songID) + "-metadata-" + str(MasterVars.songType) + ".json")
			else: metaDATACAPSULE = baseSongMetaData
		else: metaDATACAPSULE = baseSongMetaData
		if songID != null:
			if MasterVars.songType == "": loadedSong = load("res://assets/songs/" + str(songID) + "/Inst.ogg")
			else: loadedSong = load("res://assets/songs/" + str(songID) + "/Inst-" + MasterVars.songType + ".ogg")
		else: loadedSong = preload("res://assets/music/freeplayRandom.ogg")
		$capsuleBase/TextContainer/songName.text = metaDATACAPSULE["songName"]
		loadedMetaData = true



var loadedMetaData = false
var metaDataPath 
var levels
var lastType = MasterVars.songType
@onready var levelIndex = get_parent().currLevelIndex
func _process(delta: float) -> void:
	selected = get_parent().currSelect
	if not (IDCapsule == null):
		loadMetaData()
		if lastType != MasterVars.songType:
			queue_free()
			lastType = MasterVars.songType
		if $capsuleBase/icon.sprite_frames.get_animation_names().has(metaDATACAPSULE["playData"]["characters"]["opponent"]):
			$capsuleBase/icon.play(metaDATACAPSULE["playData"]["characters"]["opponent"])
		else: $capsuleBase/icon.visible = false
		if IDCapsule != 0:
			setCapsulePositions(IDCapsule)
		else: 
			positionSet[0] = 2000
			positionSet[1] = 640
		IDCapsule = songList.find(songID) + 1
		
		
		ifSelected(IDCapsule)
		variationCheck(IDCapsule)
		
	else: 
		if lastType != MasterVars.songType:
			get_parent().loadCapsules()
			lastType = MasterVars.songType
		setCapsulePositions(0)
		$capsuleBase/TextContainer/songName.text = "Random"
		$capsuleBase/rank.visible = false
		$capsuleBase/icon.visible = false
		$capsuleBase/heart.visible = false
		$capsuleBase/isNew.visible = false
		ifSelected(0)
	position.x += (positionSet[0] - position.x) / (0.045 / delta)
	position.y += (positionSet[1] - position.y) / (0.045 / delta)
	
	
	
	
	
