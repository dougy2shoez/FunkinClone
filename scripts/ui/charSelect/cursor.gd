extends Sprite2D
var pos: Vector2 = Vector2(140,521)
var selectedID = 0
var selectedIDRow = 0
var sounds: Array = [preload("res://assets/sounds/CS_select.ogg"), 
preload("res://assets/sounds/CS_confirm.ogg")]
var confirmed = false
var switchTimer: float = 0.0
@onready var stayFunky = get_parent().get_parent().get_parent().get_node("stayFunky")
func _ready() -> void:
	var audio = AudioStreamPlayer.new()
	audio.name = "sound"
	add_child(audio)
func _process(delta: float) -> void:
	if not confirmed:
		pos.x = ((selectedID + 1) * 110) + 30
		switchTimer = 0.0
		stayFunky.pitch_scale += (1 - stayFunky.pitch_scale) / (0.25/delta)
		if Input.is_action_just_pressed("ui_left"): 
			selectedID -= 1
			$sound.stream = sounds[0]
			$sound.play()
		elif Input.is_action_just_pressed("ui_right"): 
			pos.x += 110 
			selectedID += 1
			$sound.stream = sounds[0]
			$sound.play()
		if Input.is_action_just_pressed("confirm"): 
			$sound.stream = sounds[1]
			$sound.play()
			confirmed = true
	else: 
		
		switchTimer += delta
		stayFunky.pitch_scale += (0 - stayFunky.pitch_scale) / (0.35/delta)
		if switchTimer < 1.5:
			if Input.is_action_just_pressed("decline"):
				confirmed = false
			match selectedID:
				0: MasterVars.currCharacter = "bf"
				-1: MasterVars.currCharacter = "pico"
		else: get_tree().change_scene_to_file("res://scenes/freeplayMain.tscn")
	position += (pos - position) / (0.085 / delta)
	get_parent().get_node("back").position += (pos - get_parent().get_node("back").position) / (0.125 / delta)
	
