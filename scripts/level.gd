extends Node2D


func _ready() -> void:
    Globals.player_died.connect(func():
        Globals.sound_part = $sound.get_playback_position()
    )


    
    Globals.checkpoint = Vector2.ZERO

    if Globals.level % 2 == 0:

        Globals.timer = Globals.last_checkpoint
        print(Globals.timer, Globals.last_checkpoint)
        Globals.shooter_start.emit()
        Globals.platformer = false
    else:
        
        Globals.timer = 0.0
        Globals.platformer = true
        Globals.powerups = []

    $sound.play(Globals.sound_part)

    Globals.next_level.connect(next_level)


func next_level() -> void:
    Globals.sound_part = 0.0
    $ui.transition("lvl_" + str(Globals.level))