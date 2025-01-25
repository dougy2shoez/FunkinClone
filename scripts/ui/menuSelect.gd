extends Node2D


func _ready() -> void:
	var id = get_parent().id
	$animate.play(str(id) + "_" + "hold")
	position.y = (160*id) + 300
	position.x = 640
	name = str(id) + "_selectText"

func confirmedPress(id: int):
	$selected.play()
	if id == 0:
		pass
	elif id == 1:
		get_parent().get_parent().add_child(preload("res://scenes/freeplayMain.tscn").instantiate())
		get_parent().process_mode = Node.PROCESS_MODE_DISABLED

func ifSelected():
	if get_parent().selectedMenu == id:
		$animate.play(str(id) + "_" + "selected")
		if Input.is_action_just_pressed("confirm"):
			confirmedPress(id)
	else: 
		$animate.play(str(id) + "_" + "hold")

@onready var id = get_parent().id
func _process(delta: float) -> void:
	ifSelected()
	position.y = (160*id) + 300
	position.x = 640
