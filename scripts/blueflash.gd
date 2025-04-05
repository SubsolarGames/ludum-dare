extends ColorRect


func _process(delta: float) -> void:
    modulate.a = lerp(modulate.a, Globals.blue_flash, 1-(0.5**(10 * delta)))