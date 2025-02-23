extends Node2D
class_name FreeplayCapsule


func _ready() -> void:
	
	position = Vector2(2000, 640)
	pass

var metaDATACAPSULE
@onready var capsulePositions: Array = [[577,185],[628,300],[631,416],[585,532],[531,647]]
@onready var offscreenPositions: Array = [[541,-30],[519,781]]
@onready var selected = get_parent().currSelect
@onready var IDCapsule = get_parent().IDCapsule
@onready var songList = get_parent().songList
@onready var songID = songList[IDCapsule - 1] if IDCapsule != null else null
@onready var baseSongMetaData = get_parent().baseSongMetadata
var isConfirmed = false
var isConfirmedTimer: float = 0.0
var setFrames = false
var positionSet: Array = [0,0]
var isOwnedSong = false

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



var randomIntFromList
var loadedSong = load("res://assets/songs/" + str(songID) + "/Inst.ogg" if MasterVars.songType == "" else "res://assets/songs/" + str(songID) + "/Inst-" + MasterVars.songType + ".ogg") if IDCapsule != null else load("res://assets/music/freeplayRandom.ogg")
func ifSelected(id):
	if not id == null:
		if (id - selected == 1):
			MasterVars.songName = songID
			$capsuleBase.play("Selected")
			$capsuleBase/TextContainer/songName.modulate = Color("FFFFFF")
			$capsuleBase/TextContainer/songName/songName.visible = true
			$capsuleBase/TextContainer/songName/glow.material.set_shader_parameter("strength", 4)
			$capsuleBase/TextContainer/greyText.visible = false
			if Input.is_action_pressed("confirm"):
				isConfirmed = true
				get_parent().set_meta("currDJAnim", "Boyfriend DJ confirm")
				get_parent().get_node("soundsFreeplay").stream = get_parent().sounds["confirm"]
				get_parent().get_node("soundsFreeplay").play()
			if isConfirmed: selectedSong()
			if setFrames == false:
				get_parent().get_node("musicFreeplay").stream = loadedSong
				get_parent().get_node("musicFreeplay").play()
				$capsuleBase/rank.set_frame(0)
				setFrames = true
		else: 
			$capsuleBase.play("notSelected")
			$capsuleBase/TextContainer/songName.modulate = Color("aaaaaa") #aaaaaa lol
			setFrames = false
			$capsuleBase/TextContainer/songName/songName.visible = false
			$capsuleBase/TextContainer/greyText.visible = true
			$capsuleBase/TextContainer/songName/glow.material.set_shader_parameter("strength", 2)
			
	else:
		if (0 - selected == 1): #if selected
			$capsuleBase/TextContainer/greyText.visible = false
			
			if setFrames == false:
				$capsuleBase/rank.set_frame(0)
				setFrames = true
			
			$capsuleBase.play("Selected")
			$capsuleBase/TextContainer/songName.modulate = Color("FFFFFF")
			setFrames = false
			$capsuleBase/TextContainer/songName/songName.visible = true
			if Input.is_action_pressed("confirm"): 
				print(songList.size())
				get_parent().currSelect = randomIntFromList
				get_parent().get_node("soundsFreeplay").stream = get_parent().sounds["confirm"]
				get_parent().get_node("soundsFreeplay").play()
			if isConfirmed: selectedSong()
			
		else: 
			$capsuleBase.play("notSelected")
			$capsuleBase/TextContainer/songName.modulate = Color("aaaaaa")
			setFrames = false
			$capsuleBase/TextContainer/songName/songName.visible = false
			







func selectedSong():
	if IDCapsule != null:
		confirmAnim()
		isConfirmedTimer += get_process_delta_time()
		if isConfirmedTimer > 1:
			MasterVars.BPMGLOBAL = metaDATACAPSULE["timeChanges"][0]["bpm"]
			if isPlayerMix: MasterVars.songType = MasterVars.currCharacter
			elif isOwnedSong and not MasterVars.songType == "erect": MasterVars.songType = ""
			get_tree().change_scene_to_file("res://scenes/playScene.tscn")
			get_parent().queue_free()
	else: 
		pass 


var flickerTimer: float = 0.0
var flickerFrame = 0
var isShine = false 
@onready var getOGCapsuleColor = false
func confirmAnim():
	flickerTimer += get_process_delta_time()
	if flickerTimer > 0.04:
		print(flickerFrame)
		flickerTimer = 0.0
		if flickerFrame < 4:
			match flickerFrame:
				0:
					$capsuleBase/TextContainer/songName.scale = Vector2(2,.5)
					$capsuleBase/TextContainer/songName.position = Vector2(-40, 12)
				1:
					$capsuleBase/TextContainer/songName.scale = Vector2(.5,1.5)
					$capsuleBase/TextContainer/songName.position = Vector2(20,5)
				2:
					$capsuleBase/TextContainer/songName.position = Vector2(20, 6)
					$capsuleBase/TextContainer/songName.scale = Vector2(1,1)
		else:
			if not isShine:
				$capsuleBase/TextContainer/songName/glow.material.set_shader_parameter("glow_color", Color("ffffff"))
				$capsuleBase/TextContainer/songName/songName.material.set_shader_parameter("glow_color", Color("ffffff"))
				$capsuleBase/TextContainer/songName/extra/glow.material.set_shader_parameter("glow_color", Color("ffffff"))
				$capsuleBase/TextContainer/songName/songName.material.set_shader_parameter("doDaAddBlend", true)
				
				isShine = true
			else:
				$capsuleBase/TextContainer/songName/songName.material.set_shader_parameter("doDaAddBlend", false)
				$capsuleBase/TextContainer/songName/songName.material.set_shader_parameter("glow_color", get_meta("defaultColor"))
				$capsuleBase/TextContainer/songName/glow.material.set_shader_parameter("glow_color", get_meta("defaultColor"))
				$capsuleBase/TextContainer/songName/extra/glow.material.set_shader_parameter("glow_color", get_meta("defaultColor"))
				isShine = false
		flickerFrame += 1
var isPlayerMix = false
func variationCheck(id: int): # this variation bullshit took so long to code in. . it might be messy
	if baseSongMetaData["playData"].has("songVariations"):
		if not MasterVars.songType == "":
			if not baseSongMetaData["playData"]["songVariations"].has(MasterVars.songType):
				if not isOwnedSong:
					get_parent().songList.remove_at(id - 1)
					queue_free()
				else:
					if MasterVars.songType != MasterVars.currCharacter:
						get_parent().songList.remove_at(id - 1)
						queue_free()
			else: 
				pass
	elif not MasterVars.songType == "":
		if MasterVars.songType != MasterVars.currCharacter:
			get_parent().songList.remove_at(id - 1)
			queue_free()
		
		
func loadMetaData(): # this variation bullshit took so long to code in. . it might be messy
	if not loadedMetaData:
		$capsuleBase/TextContainer/songName/songName.material.set_shader_parameter("glow_color", get_meta("defaultColor"))
		$capsuleBase/TextContainer/songName/glow.material.set_shader_parameter("glow_color", get_meta("defaultColor"))
		$capsuleBase/TextContainer/songName/songName.material.set_shader_parameter("doDaAddBlend", false)
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
		if not get_parent().currPlayerData["ownedChars"].has(baseSongMetaData["playData"]["characters"]["player"]):
			if baseSongMetaData["playData"].has("songVariations"):
				if not baseSongMetaData["playData"]["songVariations"].has(MasterVars.currCharacter):
					get_parent().songList.remove_at(songList.find(songID))
					queue_free()
				else: 
					metaDATACAPSULE = loadJsonData("res://assets/data/songs/" + str(songID) + "/" + str(songID) + "-metadata-" + MasterVars.currCharacter + ".json")
					$capsuleBase/TextContainer/songName.text = metaDATACAPSULE["songName"]
					loadedSong = load("res://assets/songs/" + str(songID) + "/Inst-" + MasterVars.currCharacter + ".ogg")
					isPlayerMix = true
			else:
				get_parent().songList.remove_at(songList.find(songID)) 
				queue_free()
		else: 
			isOwnedSong = true
			if MasterVars.songType == MasterVars.currCharacter: loadedSong = load("res://assets/songs/" + str(songID) + "/Inst.ogg")

var loadedMetaData = false
var metaDataPath 
var levels
var lastType = MasterVars.songType
@onready var levelIndex = get_parent().currLevelIndex
func _process(delta: float) -> void:
	selected = get_parent().currSelect
	if not (IDCapsule == null):
		$capsuleBase/TextContainer/songName/glow.visible = true
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
		randomIntFromList = randi_range(1, songList.size())
		if lastType != MasterVars.songType:
			get_parent().loadCapsules()
			lastType = MasterVars.songType
		setCapsulePositions(0)
		$capsuleBase/TextContainer/songName.text = "Random"
		$capsuleBase/rank.visible = false
		$capsuleBase/icon.visible = false
		$capsuleBase/heart.visible = false
		$capsuleBase/isNew.visible = false
		$capsuleBase/TextContainer/songName/glow.visible = false
		ifSelected(null)
	position.x += (positionSet[0] - position.x) / (0.045 / delta)
	position.y += (positionSet[1] - position.y) / (0.045 / delta)
	
	
	
	
	
