extends Node2D

@export var explosion: PackedScene

var velocity: Vector2 = Vector2.ZERO
var damage: float = 0
var parent: CharacterBody2D
var speed: float = 0.0
var ticker: float = 0.0

func _process(delta: float) -> void:
	position += velocity * delta
	velocity = lerp(velocity, Vector2.ZERO, 1-(0.5**(3 * delta)))
	$sprite.material.set_shader_parameter("time", ticker)
	ticker += delta


func _on_timer_timeout() -> void:
	Globals.screenshake(3, 0.2)
	
	var inst: CPUParticles2D = explosion.instantiate()
	inst.position = position
	inst.rotation = rotation
	get_parent().add_child(inst)

	queue_free()
