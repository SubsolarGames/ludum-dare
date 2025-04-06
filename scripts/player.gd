extends CharacterBody2D


@export var jump_particles: PackedScene
@export var die_particles: PackedScene
@export var shell_particles: PackedScene

@export var gravity: float = 500
@export var jump_force: float = 200
@export var speed: float = 150
@export var accel: float = 8
@export var friction: float = 10
@export var top_accel: float = 15
@export var top_friction: float = 18
@export var jumps: int = 1

var invincible: bool = false
var can_move: bool = true
var current_jumps: int = 0

var pistol = Gun.new(0, 1, 0, 250, 0.2, 5, load("res://scenes/bullet.tscn"), 1, 50.0)
var shotgun = Gun.new(1, 3, 45, 200, 0.3, 10, load("res://scenes/bluebullet.tscn"), 5, 75.0)
var minigun = Gun.new(2, 2, 15, 250, 0.05, 5, load("res://scenes/bluebullet.tscn"), 1, 25.0)
var sniper = Gun.new(3, 1, 0, 300, 0.3, 0, load("res://scenes/piercebullet.tscn"), 100, 25.0)
var clawgun = Gun.new(4, 1, 0, 150, 0.75, 0, load("res://scenes/bombbullet.tscn"), 2.5, 100.0)
var wand = Gun.new(5, 36, 360, 150, 0.75, 0, load("res://scenes/homebullet.tscn"), 1, 100.0)

var gun = pistol
var gunscale: Vector2 = Vector2.ZERO

func _ready() -> void:
	if Globals.level == 8:
		can_move = false
		get_tree().create_timer(3.0).timeout.connect(func():
			can_move = true)

	Globals.game_won.connect(func():
		invincible = true
	)
	

	Globals.player = self


func _process(delta: float) -> void:
	Globals.timer += delta

func _physics_process(delta: float) -> void:

	if Globals.platformer:
		gunscale = Vector2.ZERO
		
		var direction: float = 0
		
		if not is_on_floor():
			$dust.emitting = false
			velocity.y += gravity * delta
		else:
			current_jumps = jumps
			$dust.emitting = true
			$cyoate_timer.start()

		if can_move:
			if Input.is_action_just_pressed("up") or $jump_buffer.time_left > 0:
				if current_jumps > 0 or is_on_floor() or $cyoate_timer.time_left > 0:
					$jump_buffer.stop()

					if is_on_floor() or $cyoate_timer.time_left > 0:
						$cyoate_timer.stop()
					else:
						current_jumps -= 1

					velocity.y = -jump_force

					var inst: CPUParticles2D = jump_particles.instantiate()
					inst.position = $marker.position + position
					get_parent().add_child(inst)
				else:
					if Input.is_action_just_pressed("up"):
						$jump_buffer.start()
			
			direction = Input.get_axis("left", "right")

		if direction != 0:
			$anim.play("walk")
			velocity.x = lerp(velocity.x, speed * direction, 1-(0.5**(accel * delta)))
		else:
			$anim.play("idle")
			velocity.x = lerp(velocity.x, 0.0, 1-(0.5**(friction * delta)))

		if direction > 0:
			$sprite.flip_h = false  
		if direction < 0:
			$sprite.flip_h = true
	else:
		$dust.emitting = true

		gunscale = Vector2.ONE
		var direction_x: float = Input.get_axis("left", "right")
		var direction_y: float = Input.get_axis("up", "down")
		
		var direction_vector = Vector2(direction_x, direction_y).normalized()

		if direction_vector.x > 0:
			$sprite.flip_h = false
		elif direction_vector.x < 0:
			$sprite.flip_h = true

		if direction_vector != Vector2.ZERO:
			$anim.play("walk")
			velocity = lerp(velocity, (speed - (gun.weight*int(false))) * direction_vector, 1-(0.5**(top_accel * delta)))
		else:
			$anim.play("idle")
			velocity = lerp(velocity, Vector2.ZERO, 1-(0.5**(top_friction * delta)))

		$gun.frame = gun.frame
			
		$gun.look_at(get_global_mouse_position())
		$gun.rotation_degrees = wrap($gun.rotation_degrees, 0, 360)

		if $gun.rotation_degrees > 90 and $gun.rotation_degrees < 270:
			$gun.flip_v = true
		else:
			$gun.flip_v = false

		$gun/flash.modulate.a = 0.0

		if Input.is_action_pressed("mouse action"):
			if $fire_timer.time_left == 0:

				$fire_timer.wait_time = gun.fire_rate
				$fire_timer.start()

				$gun/flash.modulate.a = 1.0
				get_tree().create_timer(0.1).timeout.connect(func():
					$gun/flash.modulate.a = 0.0)

				var shell: CPUParticles2D = shell_particles.instantiate()
				shell.position = $gun/shell_marker.global_position
				shell.rotation = $gun.rotation
				get_parent().add_child(shell)
				print((gun.fire_rate / 0.2))
				$gun/anim.speed_scale = (0.2/gun.fire_rate)
				$gun/anim.play("shoot")

				var angle = 0
				var angle_dir = 1
				for i in range(gun.bullets):

					var mod_angle = angle + randf_range(-gun.innac, gun.innac) + $gun.rotation_degrees
					var inst = gun.bullet_scene.instantiate()
					inst.position = $gun/gun_marker.global_position
					inst.rotation_degrees = mod_angle
					inst.velocity = Vector2(gun.bullet_speed, 0).rotated(deg_to_rad(mod_angle))
					inst.damage = gun.bullet_damage
					inst.parent = self
					inst.speed = gun.bullet_speed
					get_parent().add_child(inst)

					angle += angle_dir * ((gun.bullet_spread/gun.bullets) * (i+1))
					angle_dir *= -1
	
	$gun.scale = lerp($gun.scale, gunscale, 10 * delta)

	move_and_slide()


func damage(_amount: int) -> void:
	if not invincible:
		invincible = true
		can_move = false

		var inst: CPUParticles2D = die_particles.instantiate()
		inst.position = position
		inst.speed_scale = (1.0/0.1)
		get_parent().add_child(inst)

		Globals.screenshake(4, 0.2)
		Globals.slowdown(0.05, 0.5)

		if not Globals.platformer:
			Globals.level -= 1
			Globals.timer = 0.0

			Globals.slowdown(0.05, 0.75)
			Globals.screenshake(5, 0.3)

			Globals.next_level.emit()

		else:
			get_tree().create_timer(0.1).timeout.connect(func():
				invincible = false
			)
			
			get_tree().create_timer(0.5 * Engine.time_scale).timeout.connect(func():
				
				position = Globals.checkpoint

				var inst2: CPUParticles2D = die_particles.instantiate()
				inst2.position = position
				get_parent().add_child(inst2)

				can_move = true
				velocity = Vector2.ZERO
			)

func _on_area_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	damage(1)


func _on_area_body_entered(_body: Node2D) -> void:
	damage(1)


func _on_area_area_entered(_area: Area2D) -> void:
	damage(1)
