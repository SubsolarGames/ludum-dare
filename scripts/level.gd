extends Node2D


func _ready() -> void:
    Globals.checkpoint = Vector2.ZERO

    if Globals.level % 2 == 0:
        Globals.end_time = Globals.timer * Globals.time_mul
        Globals.timer = 0.0
        Globals.shooter_start.emit()
        Globals.platformer = false
    else:
        Globals.timer = 0.0
        Globals.platformer = true
        Globals.powerups = []

    Globals.next_level.connect(next_level)


func next_level() -> void:
    $ui.transition("lvl_" + str(Globals.level))