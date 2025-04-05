extends enemy_parent


var bullet_scene: PackedScene = load("res://scenes/enemy_bullet.tscn")

var in_range: bool = false


func _process(delta: float) -> void:

	if not in_range or not move:
		super._process(delta)
	else:
		if $fire_timer.time_left == 0.0:
			$fire_timer.start()
			var inst: Node2D = bullet_scene.instantiate()
			inst.position = position
			inst.damage = 1
			inst.rotation = position.angle_to_point(Globals.player.position)
			inst.velocity = Vector2(100, 0).rotated(position.angle_to_point(Globals.player.position))
			get_parent().add_child(inst)


func _on_area_2d_body_entered(_body:Node2D) -> void:
	in_range = true


func _on_area_2d_body_exited(_body:Node2D) -> void:
	in_range = false
