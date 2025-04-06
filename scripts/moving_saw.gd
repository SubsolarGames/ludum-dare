extends Path2D


@export var speed: float = 75.0
var dir: int = 1

func _process(delta: float) -> void:
    $PathFollow2D.progress += speed * delta * dir
    if $PathFollow2D.progress_ratio > 0.99 and dir == 1:
        dir = -1
    if $PathFollow2D.progress_ratio < 0.01 and dir == -1:
        dir = 1
