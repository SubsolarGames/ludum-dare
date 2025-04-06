extends Node2D


var entered: bool = false
var target: float = 0.0
var speed: float = 1

func _process(delta: float) -> void:
	if not entered:
		target = 0
		speed = 1
	
	rotation_degrees = lerp(rotation_degrees, target, speed*delta)


func _on_area_2d_body_entered(body:Node2D) -> void:
	speed = 5
	target = body.velocity.x + body.velocity.y
	entered = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	entered = false