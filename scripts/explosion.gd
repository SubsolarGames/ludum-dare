extends Sprite2D


func _on_area_2d_body_entered(body:Node2D) -> void:
    if "damage" in body:
        body.damage(10)
    if "velocity" in body:
        body.velocity -= (global_position - body.position).normalized() * 300
