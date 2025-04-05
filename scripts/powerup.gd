extends Node2D


@export var particles: PackedScene

@onready var sin_speed: float = randf_range(3, 6)
@onready var sin_amount: float = randf_range(3, 6)
@onready var sin_ticker: float = randf_range(0, 1)


func _process(delta: float) -> void:
    sin_ticker += delta * sin_speed
    $sprite.offset.y = sin(sin_ticker) * sin_amount


func _on_area_body_entered(_body:Node2D) -> void:
    queue_free()

    Globals.screenshake(3, 0.2)

    var inst: CPUParticles2D = particles.instantiate()
    inst.position = position
    get_parent().add_child(inst)
