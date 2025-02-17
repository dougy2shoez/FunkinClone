extends Node2D

@onready var comboNum = 123
func _ready() -> void:
	var comboNumPacked: PackedScene = preload("res://scenes/comboDisplay.tscn")
	var seperatedScore: String
	for x in 3: # i wrote this all in one attempt ??? i am smart lol
		if x < rs(str(comboNum)).length(): 
			seperatedScore = seperatedScore + rs(str(comboNum))[x]
		else: seperatedScore = seperatedScore + "0" 
	for digit in seperatedScore:
		add_child(comboNum)

enum {ssadajn}
var gravity = Vector2(0,500)
var setYvol = false
var xVol = randf_range(-20, 0)
var animateRating
var alphaTime = 0.0





func _process(delta: float) -> void:
	alphaTime += delta
	if modulate.a < 0:
		get_parent().queue_free()
	if alphaTime > 0.4:
		modulate.a += delta * -4.5	
	pass
	
	
func rs(s:String) -> String:
	var r := "" 
	for i in range(s.length()-1, -1, -1):
		r += s[i]
	return r
