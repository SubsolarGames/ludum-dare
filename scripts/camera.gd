extends Camera2D

@export var cursor_weight: float = 0.2

var target_position: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	Globals.update_shake(delta)
		
	offset = Vector2(randf_range(-Globals.shake, Globals.shake), randf_range(-Globals.shake, Globals.shake))

	if Globals.player != null:
		target_position = (Globals.player.position * (1.0-cursor_weight)) + (get_global_mouse_position() * cursor_weight)

	position = lerp(position, target_position, 5 * delta)
