extends CanvasLayer


var target_scene: String = ""


func _ready() -> void:
    if Globals.level % 2 == 1:
        $AnimatedSprite2D.frame = int(Globals.level / 2)
        $AnimatedSprite2D/anim.play("appear")

    $transition.visible = true
    $anim.play_backwards("appear")
    Globals.player_died.connect(func():
        $anim.play_backwards("appear"))

    Globals.finished.connect(func():
        if Globals.level != 8:
            $portaltext/anim.play("appear"))

    Globals.game_won.connect(func():
        get_tree().create_timer(1.0).timeout.connect(func():
            transition("gamewon"))
        )



func transition(scene_name: String) -> void:
    
    $anim.play("appear")
    target_scene = "res://scenes/" + scene_name + ".tscn"


func _on_anim_animation_finished(anim_name:StringName) -> void:
    if target_scene != "" and anim_name == "appear":
        get_tree().change_scene_to_file(target_scene)
