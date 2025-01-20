extends Node2D


func _ready() -> void:
	var noteID = get_parent().currSplash 
	position.x =  (111.5 * (noteID))
	$animate.play(str(noteID) + "_" + str(randi_range(1,2)))
	modulate.a = .5

func _process(delta: float) -> void:
	if $animate.get_frame() == 4: queue_free()
