extends Node2D

@export var particles: PackedScene

var velocity: Vector2 = Vector2.ZERO
var damage: float = 0
var parent: CharacterBody2D
var speed: float = 0.0

func _process(delta: float) -> void:
    position += velocity * delta



func _on_area_body_entered(body:Node2D) -> void:
    
    if "damage" in body:
        body.damage(damage)
    else:
        queue_free()
        var inst: CPUParticles2D = particles.instantiate()
        inst.position = position
        inst.rotation = rotation
        get_parent().add_child(inst)

