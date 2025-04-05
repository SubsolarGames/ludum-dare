extends Node2D


@onready var rot_speed: float = randf_range(100, 200)

func _process(delta: float) -> void:
    rotation_degrees += rot_speed * delta