extends Node2D

var enabled: bool = true
var open: bool = false


func _ready() -> void:
    if Globals.level % 2 == 0:
        enabled = false
        visible = false

    Globals.finished.connect(func():
        enabled = true
        Globals.screenshake(4, 0.4)
        visible = true
    )

func _on_area_2d_body_entered(body:Node2D) -> void:
    if enabled and not open:
        open = true
        Globals.slowdown(0.05, 0.3)
        Globals.screenshake(4, 0.3)

        body.velocity = Vector2.ZERO

        Globals.level += 1

        Globals.next_level.emit()