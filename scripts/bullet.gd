extends Node2D

@export var particles: PackedScene

var velocity: Vector2 = Vector2.ZERO
var damage: float = 0
var parent: CharacterBody2D

func _process(delta: float) -> void:
    position += velocity * delta



func _on_area_body_entered(body:Node2D) -> void:
    var inst: CPUParticles2D = particles.instantiate()
    inst.position = position
    inst.rotation = rotation
    get_parent().add_child(inst)

    if "damage" in body:
        body.damage(damage)

    queue_free()
