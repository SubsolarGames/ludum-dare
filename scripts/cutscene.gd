extends Node2D


func _process(delta: float) -> void:
    if Input.is_action_just_pressed("mouse action"):
        Globals.screenshake(3, 0.3)
        $scenes/anim.play_backwards("appear")
        get_tree().create_timer(1.0).timeout.connect(func():
            if $scenes.frame == 4:
                $transition.visible = true
                $scenes/anim.play("trans")
                get_tree().create_timer(0.5).timeout.connect(func():
                    get_tree().change_scene_to_file("res://scenes/lvl_1.tscn"))
                
            else:
                $scenes.frame += 1
                $scenes/anim.play('appear'))
