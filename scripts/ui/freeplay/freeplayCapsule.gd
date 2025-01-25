extends Node2D



func _ready() -> void:
	$capsuleBase/glow.play("default")
	pass


@onready var capsulePositions: Array = [[577,185],[628,300],[631,416],[585,532],[531,647]]
@onready var offscreenPositions: Array = [[541,-30],[519,781]]
@onready var selected = get_parent().currSelect
@onready var IDCapsule = get_parent().IDCapsule
@onready var currCHARACTER = get_parent().currCHARACTER
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




var loadedSong = load("res://assets/songs/" + str(songID) + "/" + "Inst.ogg") if IDCapsule != null else load("res://assets/music/freeplayRandom.ogg")
func ifSelected(id):
	if not id == null:
		if (id - selected == 1):
			MasterVars.songName = songID
			$capsuleBase/lcdScreenBacking.play("default")
			if Input.is_action_pressed("confirm"):
				selectedSong()
			if setFrames == false:
				get_parent().get_node("musicFreeplay").stream = loadedSong
				get_parent().get_node("musicFreeplay").play()
				$capsuleBase/rank.set_frame(0)
				setFrames = true
			$capsuleBase/glow.modulate.a = 1
			$capsuleBase/greyText.visible = false
			$capsuleBase/TextContainer/songName/glowEffect6.visible = true
			$capsuleBase/TextContainer/songName/glowEffect7.visible = true
			setGlowStrength(58)
		else: 
			$capsuleBase/lcdScreenBacking.play("notSelected")
			$capsuleBase/glow.modulate.a = 0.45
			setFrames = false
			$capsuleBase/greyText.visible = true
			setGlowStrength(30)
	else: 
		if (0 - selected == 1):
			$capsuleBase/lcdScreenBacking.play("default")
			if Input.is_action_pressed("confirm"):
				pass
			if setFrames == false:
				$capsuleBase/rank.set_frame(0)
				setFrames = true
			$capsuleBase/glow.modulate.a = 1
			$capsuleBase/greyText.visible = false
			setGlowStrength(40)
		else: 
			$capsuleBase/lcdScreenBacking.play("notSelected")
			$capsuleBase/glow.modulate.a = 0.45
			setFrames = false
			$capsuleBase/greyText.visible = true
			setGlowStrength(30)







func selectedSong():
	MasterVars.BPMGLOBAL = metaDATACAPSULE["timeChanges"][0]["bpm"]
	get_tree().change_scene_to_file("res://scenes/playScene.tscn")
	get_parent().get_parent().queue_free()	



var metaDATACAPSULE

func setGlowVisble(truee: bool):
	$capsuleBase/TextContainer/songName/glowEffect.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect2.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect3.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect4.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect5.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect6.visible = truee
	$capsuleBase/TextContainer/songName/glowEffect7.visible = truee

func setGlowStrength(stgth: int):
	$capsuleBase/TextContainer/songName/glowEffect.material.set_shader_parameter('glow_strength',stgth)
	$capsuleBase/TextContainer/songName/glowEffect2.material.set_shader_parameter('glow_strength',(stgth/2))
	$capsuleBase/TextContainer/songName/glowEffect3.material.set_shader_parameter('glow_strength',stgth)
	$capsuleBase/TextContainer/songName/glowEffect4.material.set_shader_parameter('glow_strength',(stgth/2))
	$capsuleBase/TextContainer/songName/glowEffect5.material.set_shader_parameter('glow_strength',(stgth/2))

func variationCheck(id: int):
	if baseSongMetaData["playData"].has("songVariations"):
		if not baseSongMetaData["playData"]["songVariations"].has(MasterVars.songType) and not MasterVars.songType == "":
			loadedMetaData = false
			loadMetaData()
			get_parent().erasedSongs.append({"songID": songID, "indexed": songList.find(songID)})
			get_parent().songList.remove_at(id - 1)
	elif not MasterVars.songType == "": 
		loadedMetaData = false
		loadMetaData()
		get_parent().erasedSongs.append({"songID": songID, "indexed": songList.find(songID)})
		get_parent().songList.remove_at(id - 1)

func loadMetaData():
	if not loadedMetaData:
		if baseSongMetaData["playData"].has("songVariations"):
			if baseSongMetaData["playData"]["songVariations"].has(MasterVars.songType):
				metaDATACAPSULE = loadJsonData("res://assets/data/songs/" + str(songID) + "/" + str(songID) + "-metadata-" + str(MasterVars.songType) + ".json")
			else: metaDATACAPSULE = baseSongMetaData
		else: metaDATACAPSULE = baseSongMetaData
		loadedSong = load("res://assets/songs/" + str(songID) + "/" + "Inst.ogg")
		loadedMetaData = true
		$capsuleBase/TextContainer/songName.text = metaDATACAPSULE["songName"]



var loadedMetaData = false
var metaDataPath 
var levels
@onready var levelIndex = get_parent().currLevelIndex
func _process(delta: float) -> void:
	selected = get_parent().currSelect
	if not (IDCapsule == null):
		loadMetaData()
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
		setCapsulePositions(0)
		$capsuleBase/TextContainer/songName.text = "Random"
		setGlowVisble(0 - selected == 1)
		$capsuleBase/rank.visible = false
		$capsuleBase/icon.visible = false
		$capsuleBase/heart.visible = false
		$capsuleBase/isNew.visible = false
		ifSelected(0)
	position.x += (positionSet[0] - position.x) / (0.05 / delta)
	position.y += (positionSet[1] - position.y) / (0.05 / delta)
	
	
	
	
	
