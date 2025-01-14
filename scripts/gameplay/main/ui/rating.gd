
extends CharacterBody2D


func _ready() -> void:
	animateRating = get_parent().get_parent().rating
	velocity.y = randf_range(-150.0, -170.0)
	velocity.x = randf_range(-10.0, 0)
	$animate.play(str(animateRating))

enum {ssadajn}
var gravity = Vector2(0,500)
var setYvol = false
var xVol = randf_range(-20, 0)
var animateRating
var alphaTime = 0.0

func _physics_process(delta: float) -> void:
	velocity += gravity * delta
	move_and_slide()



func _process(delta: float) -> void:
	alphaTime += delta
	if modulate.a < 0:
		get_parent().queue_free()
	if alphaTime > 0.4:
		modulate.a += delta * -4.5
	pass
	
	
