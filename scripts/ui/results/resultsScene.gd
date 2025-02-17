extends Node2D

var clearPercent = 0
var clearPercentSmooth = 0.0
var lastSmooth = 0
var missedNotes = MasterVars.songStats["rating"]["missed"] + MasterVars.songStats["rating"]["shit"] + MasterVars.songStats["rating"]["bad"]
var sounds: Array = [preload("res://assets/sounds/scrollMenu.ogg"), preload("res://assets/sounds/confirmMenu.ogg")]
var totalPlayerNotes = MasterVars.songStats["rating"]["missed"] + MasterVars.songStats["rating"]["shit"] + MasterVars.songStats["rating"]["bad"] + MasterVars.songStats["rating"]["good"] + MasterVars.songStats["rating"]["sick"]
func _ready() -> void:
	$BlackBar.position = Vector2(540, 600)
	lastSmooth = round(clearPercentSmooth)
	$sound.stream = sounds[0]
	$audio.stream = load("res://assets/music/resultsScreen/pico/resultsNORMAL-pico.ogg")
	$audio.play()
	pass
	clearPercent = int((float(totalPlayerNotes - missedNotes) / float(totalPlayerNotes)) * 100)
	clearPercentSmooth = float(clearPercent) / 2
	#if floor(clearPercent) == 100:
	#	$resultsCharacter.atlas = "res://assets/images/ResultsScreen/results-" + MasterVars.currCharacter + "/resultsPERFECT" 
var flashTimer = 0
var doFlash = false
var drawNumFinal = false
func doClear(delta: float):
	if not drawNumFinal:
		clearPercentSmooth += ((clearPercent - 1) - clearPercentSmooth) / (0.4 / delta)
		if lastSmooth != round(clearPercentSmooth):
			$sound.play()
			
			lastSmooth = round(clearPercentSmooth)
			$clearNum.createClearNum(lastSmooth)
	if lastSmooth == clearPercent - 1:
		flashTimer += delta
		if flashTimer > 0.75:
			if not drawNumFinal:
				$sound.stream = sounds[1]
				$sound.play()
				$clearNum.createClearNum(clearPercent)
				drawNumFinal = true
			if flashTimer > 1: 
				pass
				if flashTimer > 2:
					$clearNum.modulate.a -= delta * 1
				
func _process(delta: float) -> void:
	if $ResultsText.frame > 4: $SoundSystem.play("default")
	if $SoundSystem.frame > 9: $popInText.play("default")
	if $popInText.frame > 9: $popInScore.play("default")
	if $popInScore.frame > 1: 
		doClear(delta)
		$flash.modulate.a += (0 - $flash.modulate.a) / (0.1 / delta)
		if not doFlash:
			$clearNum.visible = true
			$flash.modulate.a = 1
			doFlash = true
	if Input.is_action_just_pressed("confirm"):
		get_tree().change_scene_to_file("res://scenes/freeplayMain.tscn")
	$BlackBar.position.x += (540 - $BlackBar.position.x) / (0.25 / delta) 
	$BlackBar.position.y += (336 - $BlackBar.position.y) / (0.1 / delta) 
	
	
