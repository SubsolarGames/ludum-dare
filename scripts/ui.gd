extends CanvasLayer


var target_scene: String = ""


func _ready() -> void:
    $anim.play_backwards("appear")


func transition(scene_name: String) -> void:
    $anim.play("appear")
    target_scene = "res://scenes/" + scene_name + ".tscn"


func _on_anim_animation_finished(anim_name:StringName) -> void:
    if target_scene != "" and anim_name == "appear":
        get_tree().change_scene_to_file(target_scene)
