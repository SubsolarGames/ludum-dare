extends Node


var player: CharacterBody2D

var shake: float = 0.0
var shake_ticker: float = 0.0

var screenshake_mul: float = 1.0


func screenshake(strength, length) -> void:
    shake = max(shake, strength) * screenshake_mul
    shake_ticker += max(length-shake_ticker, 0)


func slowdown(strength, length) -> void:
    Engine.time_scale = strength
    await get_tree().create_timer(length * strength).timeout
    Engine.time_scale = 1.0


func update_shake(delta: float) -> void:
    shake = move_toward(shake, 0.0, delta * (1.0/shake_ticker))
    shake_ticker -= delta

    if shake_ticker < 0:
        shake = 0
        