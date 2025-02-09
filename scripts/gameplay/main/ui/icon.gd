extends Node2D

@onready var iconScene = preload("res://scenes/icon.tscn")
@onready var iconAnimate: String
@onready var isEnemy = false
func _ready() -> void:
	pass

var lastBeat = 0
var hpPos
var createdIcons = false
func createIcon(player: String, opp: String):
	iconAnimate = player
	add_child(iconScene.instantiate())
	iconAnimate = opp
	isEnemy = true
	add_child(iconScene.instantiate())
	createdIcons = true



func _process(delta: float) -> void:
	if createdIcons:
		hpPos = get_parent().hpPos
		position.x += (((hpPos - 1.91) * -299) - position.x) / (.1 / delta)
		if lastBeat != get_parent().get_parent().get_node("Conductor").currBeat:
			$enemyIcon.scale.x += 0.05
			$playerIcon.position.x += 6
			$enemyIcon.scale.y += 0.05
			$playerIcon.scale.x += -0.05
			$enemyIcon.position.x += -6
			$playerIcon.scale.y += 0.05
			scale.x += 0.15
			scale.y += 0.15
			lastBeat = get_parent().get_parent().get_node("Conductor").currBeat
		setIconBopTween(delta)



func setIconBopTween(delta: float):
	$playerIcon.scale.x += (-1 - $playerIcon.scale.x) / (0.1 / delta)
	$playerIcon.scale.y += (1 - $playerIcon.scale.y) / (0.1 / delta)
	$enemyIcon.scale.x += (1 - $enemyIcon.scale.x) / (0.1 / delta)
	$enemyIcon.scale.y += (1 - $enemyIcon.scale.y) / (0.1 / delta)
	scale.y += (1 - scale.x) / (0.115/delta)
	scale.x += (1 - scale.x) / (0.115/delta)
