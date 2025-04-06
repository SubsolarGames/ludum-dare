extends Sprite2D

@export var always: bool = false
@export var rot_speed: float = 100.0


func _process(delta: float) -> void:
    position = get_global_mouse_position()

    rotation_degrees += rot_speed * delta

    visible = not Globals.platformer or always