extends Node


signal shooter_start
signal next_level
signal player_died 
signal finished
signal game_won

var player: CharacterBody2D
var checkpoint: Vector2 = Vector2.ZERO

var platformer: bool = true
var shake: float = 0.0
var shake_ticker: float = 0.0
var screenshake_mul: float = 1.0
var timer: float = 0
var time_mul: float = 1

var end_time: float = 0.0
var powerups: Array[float] = []
var blue_flash: float = 0.0
var level: int = 1
var satan_pos: Vector2 = Vector2.ZERO
var playerded: bool = false
var saved_marker: Array[float] = []
var sound_part: float = 0.0
var last_checkpoint: float = 0.0


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
        