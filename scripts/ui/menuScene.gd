extends Node2D
@onready var splashText = preload("res://scenes/splashText.tscn")
@onready var menuSelect = preload("res://scenes/menuSelect.tscn")
@onready var textSplashSpawn = ""
@onready var beatsWait
@onready var BPM = 102.0
@onready var currBeat = 0
@onready var beatTime = 0.0
@onready var allowPass = true
@onready var currTextArray = 0
@onready var introText = true
@onready var isOnStartScreen = true
@onready var id
@onready var selectedMenu
@onready var createdText = false
@onready var beatsShowText: Array = [{"text": "dougy2shoe","beat": 0, "doClear": false, "beatsWait": 4},{"text": "presents","beat": 3, "doClear": true, "beatsWait": 1},{"text": "pico","beat": 5, "doClear": false, "beatsWait": 3},{"text": "funny", "beat": 7, "doClear": true, "beatsWait": 1},{"text": "prototype", "beat": 9, "doClear": false, "beatsWait": 3},{"text": "supremer","beat": 11, "doClear": true, "beatsWait": 1},{"text": "Friday","beat": 12, "doClear": false, "beatsWait": 4},{"text": "Night","beat": 13, "doClear": false, "beatsWait": 3},{"text": "Funkin'","beat": 14, "doClear": false, "beatsWait": 2},{"text": "Clone","beat": 15, "doClear": true, "beatsWait": 1}]
func _ready() -> void:
	pass
func _process(delta: float):
	beatTime += delta
	if beatTime > (60/BPM) * currBeat:
		currBeat += 1
	if introText == true:
		if currBeat > beatsShowText[currTextArray]["beat"]:
			createMenuText(beatsShowText[currTextArray]["text"],beatsShowText[currTextArray]["beatsWait"])
			if currTextArray != beatsShowText.size(): currTextArray += 1
			else: introText = false
			
	if currTextArray == beatsShowText.size(): introText = false
	if introText == false and $Gradient.fullScreenCover == true and createdText == false:
		for i in 4: 
			id = i
			add_child(menuSelect.instantiate())
		createdText = true
	else:
		selectedMenu = 0
		
		

func createMenuText(text: String, beatsLength: float):
	textSplashSpawn = text
	beatsWait = beatsLength
	add_child(splashText.instantiate())
		
		
