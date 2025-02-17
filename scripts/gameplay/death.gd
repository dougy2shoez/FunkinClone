extends Node2D
var timer = 0.0
var timerBPM : float = 0.0
var initDeath = false
var twitchTimer: float = 0.0
var twitchTarget: float
func _ready() -> void:
	visible = false
	name = "deathCharScn"
func onDeath():
	match MasterVars.currCharacter:
		"bf":
			if not initDeath:
				modulate.a = 1.0
				visible = true
				$sfx.stream = preload("res://assets/sounds/gameplay/gameover/fnf_loss_sfx.ogg")
				$sfx.play()
				$sekle.play("default")
				$sekle/hand.play("default")
				$sekle/hand.frame = $sekle.frame
				$mic.play("default")
				$balls.visible = false
				$"retry confirm".visible = false
				$sekle/hand.visible = true
				initDeath = true
			if $sekle.frame > 25:
				$sekle/hand.visible = false
				$sekle.play("loop")
				$balls.frame = 2
				$balls.play("default")
				$balls.visible = true
				$sfx.stream = preload("res://assets/music/gameplay/gameover/gameOver.ogg")
				$sfx.play()
			elif $sekle.animation == "loop":
				twitchTimer += get_process_delta_time()
				timerBPM += get_process_delta_time()
				if Input.is_action_just_pressed("confirm"):
					$"retry confirm".visible = true
					$balls.visible = false
					$"retry confirm".play("default")
					$sfx.stream = preload("res://assets/music/gameplay/gameover/gameOverEnd.ogg")
					$sfx.play()
					twitchTimer = 0.0
					$sekle.play("confirm")
				if timerBPM > (60.0 / 100.0):
					$balls.frame = 0
					$balls.play("default")
					timerBPM = 0.0
				if twitchTimer > twitchTarget:
					$sekle.frame = 1
					print("set")
					twitchTimer = 0.0
					twitchTarget = randf_range(0.25, 1.25)
			elif $sekle.animation == "confirm":
				if twitchTimer > 1:
					modulate.a -= get_process_delta_time() * 0.5
					if modulate.a < 0.01:
						get_parent().get_parent().reInitSong()
						queue_free()
						visible = false
				twitchTimer += get_process_delta_time()
		"pico":
			if not initDeath:
				modulate.a = 1.0
				visible = true
				$sfx.stream = preload("res://assets/sounds/gameplay/gameover/fnf_loss_sfx.ogg")
				$sfx.play()
				$sekle.play("default")
				$sekle/hand.play("default")
				$sekle/hand.frame = $sekle.frame
				$mic.play("default")
				$balls.visible = false
				$"retry confirm".visible = false
				$sekle/hand.visible = true
				initDeath = true
			if $sekle.frame > 25:
				$sekle/hand.visible = false
				$sekle.play("loop")
				$balls.frame = 2
				$balls.play("default")
				$balls.visible = true
				$sfx.stream = preload("res://assets/music/gameplay/gameover/gameOver.ogg")
				$sfx.play()
			elif $sekle.animation == "loop":
				twitchTimer += get_process_delta_time()
				timerBPM += get_process_delta_time()
				if Input.is_action_just_pressed("confirm"):
					$"retry confirm".visible = true
					$balls.visible = false
					$"retry confirm".play("default")
					$sfx.stream = preload("res://assets/music/gameplay/gameover/gameOverEnd.ogg")
					$sfx.play()
					twitchTimer = 0.0
					$sekle.play("confirm")
				if timerBPM > (60.0 / 100.0):
					$balls.frame = 0
					$balls.play("default")
					timerBPM = 0.0
				if twitchTimer > twitchTarget:
					$sekle.frame = 1
					print("set")
					twitchTimer = 0.0
					twitchTarget = randf_range(0.25, 1.25)
			elif $sekle.animation == "confirm":
				if twitchTimer > 1:
					modulate.a -= get_process_delta_time() * 0.5
					if modulate.a < 0.01:
						get_parent().get_parent().reInitSong()
						queue_free()
						visible = false
				twitchTimer += get_process_delta_time()
		"tankman":
			pass
		"dad":
			pass
