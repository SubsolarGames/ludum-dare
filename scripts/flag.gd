extends Node2D

@export var particles: PackedScene
var got: bool = false



func _on_area_2d_body_entered(body:Node2D) -> void:
    if not got:
        Globals.checkpoint = position
        got = true

        Globals.screenshake(3, 0.3)

        var inst: CPUParticles2D = particles.instantiate()
        inst.position = position
        get_parent().add_child(inst)

        $AnimatedSprite2D.frame = 1