extends Node2D

@export var particles: PackedScene

var velocity: Vector2 = Vector2.ZERO
var damage: float = 0
var parent: CharacterBody2D
var speed: float = 0.0

@onready var accel: float =randf_range(1, 5)

func _process(delta: float) -> void:
    position += velocity * delta
    velocity = lerp(velocity, (get_global_mouse_position() - position).normalized() * (speed+50), 1-(0.5**(accel * delta)))


func _on_area_body_entered(body:Node2D) -> void:
    var inst: CPUParticles2D = particles.instantiate()
    inst.position = position
    inst.rotation = rotation
    get_parent().add_child(inst)

    if "damage" in body:
        body.damage(damage)

    queue_free()
