extends enemy_parent


func _process(delta: float) -> void:
    velocity = lerp(velocity, ((Globals.player.position)-position).normalized() * speed, 1-(0.5**(accel * delta)))
    rotation = velocity.angle()

    move_and_slide()