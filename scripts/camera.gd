extends Camera2D

@export var always: bool = false
@export var cursor_weight: float = 0.0
@export var speed: float = 10.0
@export var moveable: bool = false

var won: bool = false
var target_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	Globals.game_won.connect(func():
		won = true
	)

func _physics_process(delta: float) -> void:
	cursor_weight = 0.2 * int(not Globals.platformer or always)

	Globals.update_shake(delta)
		
	offset = Vector2(randf_range(-Globals.shake, Globals.shake), randf_range(-Globals.shake, Globals.shake))

	if won:
		target_position = (Globals.satan_pos * (1.0-cursor_weight)) + (get_global_mouse_position() * cursor_weight)
	else:
		if Globals.player != null:
			target_position = (Globals.player.position * (1.0-cursor_weight)) + (get_global_mouse_position() * cursor_weight)
	if always:
		target_position = (get_global_mouse_position() * cursor_weight)

	if not moveable:
		position = lerp(position, target_position, speed * delta)
