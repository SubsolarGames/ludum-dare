extends Node2D


@export var obj: PackedScene
@export var time: float

func _ready() -> void:
    $Timer.wait_time = time
    $Timer.start()

func _on_timer_timeout() -> void:
    var inst = obj.instantiate()
    inst.position = position
    get_parent().add_child(inst)

    $Timer.wait_time *= 0.95
    $Timer.start()