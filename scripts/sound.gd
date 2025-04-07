extends AudioStreamPlayer2D

@export var startplay: bool = false
@export var loop: bool = false
@export var pitch_range: float = 0.2


func _ready() -> void:
    if startplay:
        p()

    

func p():
    pitch_scale = randf_range(1-pitch_range, 1+pitch_range)
    play()

func _on_finished() -> void:
    if loop:
        p()
